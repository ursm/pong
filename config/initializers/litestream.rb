Rails.application.configure do
  config.litestream.password           = Rails.application.config_for(:admin_auth).password
  config.litestream.replica_access_key = Rails.application.credentials.dig(:litestream, :replica_access_key)
  config.litestream.replica_bucket     = Rails.application.credentials.dig(:litestream, :replica_bucket)
  config.litestream.replica_key_id     = Rails.application.credentials.dig(:litestream, :replica_key_id)
  config.litestream.username           = Rails.application.config_for(:admin_auth).name
end
