require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = true
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = true
  config.require_master_key = true
  config.assets.compile = true
  config.force_ssl = true

  # ✅ Logger setup: Write to both STDOUT and production.log
  log_file = File.open(Rails.root.join("log/production.log"), 'a')
  log_file.sync = true

  file_logger = Logger.new(log_file)
  stdout_logger = Logger.new(STDOUT)

  file_logger.formatter = Logger::Formatter.new
  stdout_logger.formatter = Logger::Formatter.new

  # MultiIO to write to both
  class MultiIO
    def initialize(*targets)
      @targets = targets
    end

    def write(*args)
      @targets.each { |t| t.write(*args) }
    end

    def close
      @targets.each(&:close)
    end

    def flush
      @targets.each(&:flush)
    end
  end

  multi_logger = Logger.new(MultiIO.new(stdout_logger, file_logger))
  multi_logger.formatter = Logger::Formatter.new
  config.logger = ActiveSupport::TaggedLogging.new(multi_logger)

  config.log_tags = [:request_id]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # ✅ Active Storage
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
    password: 'ktib hmnt eief wdjq',
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # ✅ I18n and Schema
  config.i18n.fallbacks = true
  config.active_record.dump_schema_after_migration = false
  config.action_controller.raise_on_missing_callback_actions = true
end
