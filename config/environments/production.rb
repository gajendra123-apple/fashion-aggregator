require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = true
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = true
  config.require_master_key = true
  config.assets.compile = true
  config.force_ssl = true

  # ⚙️ Logger: Output to both STDOUT and production.log
  logfile = ActiveSupport::Logger.new(Rails.root.join("log/production.log"))
  logfile.formatter = Logger::Formatter.new

  stdout_logger = ActiveSupport::Logger.new(STDOUT)
  stdout_logger.formatter = Logger::Formatter.new

  combined_logger = ActiveSupport::Logger.new(stdout_logger)
  combined_logger.extend(ActiveSupport::Logger.broadcast(logfile))

  config.logger = ActiveSupport::TaggedLogging.new(combined_logger)

  config.log_tags = [ :request_id ]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  config.active_storage.service = :amazon
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_record.dump_schema_after_migration = false

  config.action_mailer.default_url_options = {
    host: 'ecommerce-application-wsic.onrender.com',
    protocol: 'https'
  }

  config.action_controller.raise_on_missing_callback_actions = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: 'janakthakur346@gmail.com',
    password: 'ktib hmnt eief wdjq',
    authentication: 'plain',
    enable_starttls_auto: true
  }
end
