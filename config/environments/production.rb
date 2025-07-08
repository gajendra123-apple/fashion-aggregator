require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ✅ Reloading and eager loading
  config.enable_reloading = true
  config.eager_load = true

  # ✅ Error reporting and caching
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = true

  # ✅ Credentials
  config.require_master_key = true

  # ✅ Assets
  config.assets.compile = true

  # ✅ Force HTTPS
  config.force_ssl = true

  # ✅ Log to STDOUT and to log/production.log
  logfile = File.open(Rails.root.join("log/production.log"), 'a')
  logfile.sync = true

  file_logger = ActiveSupport::Logger.new(logfile)
  file_logger.formatter = Logger::Formatter.new

  stdout_logger = ActiveSupport::Logger.new(STDOUT)
  file_logger   = ActiveSupport::Logger.new(Rails.root.join("log/production.log"))

  stdout_logger.formatter = Logger::Formatter.new

  # Broadcast logs to both STDOUT and file
  stdout_logger.extend(ActiveSupport::Logger.broadcast(file_logger))
  config.logger = ActiveSupport::TaggedLogging.new(stdout_logger)

  config.log_tags = [:request_id]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # ✅ Active Storage (S3 or local)
  config.active_storage.service = :amazon

  # ✅ Action Mailer
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = {
    host: 'ecommerce-application-wsic.onrender.com',
    protocol: 'https'
  }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: 'janakthakur346@gmail.com',
    password: 'ktib hmnt eief wdjq', # ⚠️ Use ENV variable for real deployments
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # ✅ I18n & schema
  config.i18n.fallbacks = true
  config.active_record.dump_schema_after_migration = false

  # ✅ Other settings
  config.action_controller.raise_on_missing_callback_actions = true
end
