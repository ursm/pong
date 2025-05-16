const INSTANCE_ORIGINS = {
  app1: 'https://app1.ursm.jp',
  app2: 'https://app2.ursm.jp'
};

const ORIGINS         = Object.values(INSTANCE_ORIGINS);
const READ_METHODS    = new Set(['GET', 'HEAD', 'OPTIONS']);
const FAILOVER_STATUS = new Set([405, 502, 503, 504, 520, 521, 522, 523, 524, 525, 526]);

export default {
  async fetch(req, env, ctx) {
    if (READ_METHODS.has(req.method)) {
      const origin = pick(ORIGINS);

      try {
        return await proxyTo(origin, req, { failover: true });
      } catch {
        return proxyTo(pick(without(ORIGINS, origin)), req);
      }
    }

    const primary      = await env.KV.get('primary');
    const maybePrimary = primary || pick(ORIGINS);

    let res;

    try {
      res = await proxyTo(maybePrimary, req, { failover: true });
    } catch {
      res = await proxyTo(pick(without(ORIGINS, maybePrimary)), req);
    }

    const replay = res.headers.get('Fly-Replay');

    if (!replay) {
      if (res.ok && primary !== maybePrimary) {
        ctx.waitUntil(env.KV.put('primary', maybePrimary));
      }

      return res;
    }

    const instance   = replay.replace(/^instance=/, '');
    const newPrimary = INSTANCE_ORIGINS[instance];

    if (!newPrimary) return res;

    res = await proxyTo(newPrimary, req);

    if (res.ok && primary !== newPrimary) {
      ctx.waitUntil(env.KV.put('primary', newPrimary));
    }

    return res;
  }
};

function pick(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

function without(arr, item) {
  return arr.filter(i => i !== item);
}

async function proxyTo(origin, req, opts = {}) {
  const needsClone = !READ_METHODS.has(req.method) && req.body;
  const controller = new AbortController();
  const timer      = setTimeout(() => controller.abort(), 3000);

  const newReq = new Request(req.url, {
    method:  req.method,
    headers: req.headers,
    body:    needsClone ? await req.clone().arrayBuffer() : req.body,
    signal:  controller.signal,

    cf: {
      resolveOverride: new URL(origin).hostname
    }
  });

  const res = await fetch(newReq);

  clearTimeout(timer);

  if (opts.failover && FAILOVER_STATUS.has(res.status)) {
    throw new Error('FAILOVER');
  }

  return res;
}
