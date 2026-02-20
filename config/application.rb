require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.load_defaults 7.1

    config.time_zone = "Tokyo"

    config.autoload_paths << Rails.root.join("app/services")

    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

    config.generators.system_tests = nil
  end
end
