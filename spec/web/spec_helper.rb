# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'contentful_model'
require 'capybara'
require 'capybara/dsl'
require 'capybara/minitest'
require 'rack/test'
require_relative '../../app'
require_relative '../../.env.rb'
require_relative '../../config/initializers/contentful_model'

Gem.suffix_pattern

require_relative '../minitest_helper'

begin
  require 'refrigerator'
rescue LoadError
  # ignore
else
  Refrigerator.freeze_core
end

App.plugin(:not_found) { raise '404 - File Not Found' }
App.plugin :error_handler, &method(:raise)

Capybara.app = App.freeze.app

class Minitest::HooksSpec
  include Rack::Test::Methods
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def app
    Capybara.app
  end

  after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
