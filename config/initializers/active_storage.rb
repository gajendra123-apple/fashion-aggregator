# config/initializers/active_storage.rb

Rails.application.config.active_storage.service = :amazon

if Rails.env.production?
  # Configuration for Amazon S3
  Rails.application.config.active_storage.service_urls_expire_in = 7.days
else
  # Configuration for local disk storage
  Rails.application.config.active_storage.service = :local
end