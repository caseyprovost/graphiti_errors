# https://github.com/rails/rails/blob/v5.0.0.beta1/railties/test/isolation/abstract_unit.rb

# Usage Example:
#
# require 'support/isolated_unit'
#
# class RailtieTest < ActiveSupport::TestCase
#   include ActiveSupport::Testing::Isolation
#
#   class WithRailsDefinedOnLoad < RailtieTest
#     setup do
#       require 'rails'
#       require 'active_model_serializers'
#       make_basic_app
#     end
#
#     # some tests
#   end
#
#   class WithoutRailsDefinedOnLoad < RailtieTest
#     setup do
#       require 'active_model_serializers'
#       make_basic_app
#     end
#
#     # some tests
#   end
# end
#
# Note:
# It is important to keep this file as light as possible
# the goal for tests that require this is to test booting up
# rails from an empty state, so anything added here could
# hide potential failures
#
# It is also good to know what is the bare minimum to get
# Rails booted up.
require "bundler/setup" unless defined?(Bundler)
require "rails"

module BasicRailsApp
  module_function

  # Make a very basic app, without creating the whole directory structure.
  # Is faster and simpler than generating a Rails app in a temp directory
  def generate
    @app = Class.new(Rails::Application) {
      config.eager_load = false
      config.session_store :cookie_store, key: "_myapp_session"
      config.active_support.deprecation = :log
      config.root = File.dirname(__FILE__)
      config.log_level = :info
      # Set a fake logger to avoid creating the log directory automatically
      fake_logger = Logger.new(nil)
      config.logger = fake_logger
      Rails.application.routes.default_url_options = {host: "example.com"}
    }
    @app.respond_to?(:secrets) && @app.secrets.secret_key_base = "3b7cd727ee24e8444053437c36cc66c4"

    yield @app if block_given?
    @app.initialize!
  end
end
