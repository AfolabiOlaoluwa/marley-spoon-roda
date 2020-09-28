# frozen_string_literal: true

ENV['MT_NO_PLUGINS'] = '1'
gem 'minitest'
require 'minitest/global_expectations/autorun'
require 'minitest/hooks/default'

class Minitest::HooksSpec
  def log
    LOGGER.level = Logger::INFO
    yield
  ensure
    LOGGER.level = Logger::FATAL
  end
end
