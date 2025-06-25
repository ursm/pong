Sentry.init do |config|
  config.breadcrumbs_logger   = %i[active_support_logger http_logger]
  config.send_default_pii     = true
  config.traces_sample_rate   = 1.0
  config.profiles_sample_rate = 1.0
  config.enable_logs          = true
end
