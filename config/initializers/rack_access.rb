Rails.application.config.middleware.use Rack::Access, **{
  "/admin" => [ "127.0.0.1", ENV["ADMIN_IP"] ].compact
}
