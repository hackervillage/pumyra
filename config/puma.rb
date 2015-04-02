workers ENV.fetch('WEB_CONCURRENCY') { 2 }.to_i

threads_count = ENV.fetch('MAX_THREADS') { 5 }.to_i
threads threads_count, threads_count

rackup DefaultRackup
port ENV.fetch('PORT') { 3000 }
environment ENV.fetch('RACK_ENV') { 'development' }
preload_app!

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  #      https://github.com/codetriage/codetriage/blob/master/config/puma.rb
  ActiveRecord::Base.establish_connection

  # If you are using Redis but not Resque, change this
  # if defined?(Resque)
  #   Resque.redis = ENV["OPENREDIS_URL"] || "redis://127.0.0.1:6379"
  #   Rails.logger.info('Connected to Redis')
  # end
end