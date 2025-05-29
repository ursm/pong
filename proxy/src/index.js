const ORIGINS = [
  'https://app1.ursm.jp',
  'https://app2.ursm.jp'
];

const READ_METHODS    = new Set(['GET', 'HEAD', 'OPTIONS']);
const FAILOVER_STATUS = new Set([405, 502, 503, 504, 521, 522, 523, 524, 525, 526, 527]);

export default {
  async fetch(request, env, ctx) {
    const { method } = request;

    if (READ_METHODS.has(method)) {
      const origin = sample(ORIGINS);

      return withFailover(proxyTo(origin, request), () => {
        const fallback = sample(ORIGINS.filter(o => o !== origin));

        return proxyTo(fallback, request);
      });
    }

    const primary = await env.KV.get("primary") || await detectAndSavePrimary(env, ctx);

    return withFailover(proxyTo(primary, request), async () => {
      const newPrimary = await detectAndSavePrimary(env, ctx);

      return proxyTo(newPrimary, request);
    });
  }
};

function sample(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

async function withFailover(promise, fallback) {
  try {
    const res = await promise;

    return FAILOVER_STATUS.has(res.status) ? fallback() : res;
  } catch {
    return fallback();
  }
}

function proxyTo(origin, request) {
  const url       = new URL(request.url);
  const originURL = new URL(origin);

  url.protocol = originURL.protocol;
  url.hostname = originURL.hostname;
  url.port     = originURL.port;

  return fetch(new Request(url.toString(), request));
}

async function detectAndSavePrimary(env, ctx) {
  const primary = await Promise.any(ORIGINS.map(async (origin) => {
    const res = await fetch(`${origin}/role`, { signal: AbortSignal.timeout(1000) });

    if (await res.text() !== 'primary') throw new Error('Not primary');

    return origin;
  }));

  ctx.waitUntil(env.KV.put("primary", primary));

  return primary;
}
