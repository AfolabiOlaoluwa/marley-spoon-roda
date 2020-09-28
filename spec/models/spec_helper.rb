# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require_relative '../../.env.rb'
require_relative '../../models/recipe'
require_relative '../../config/initializers/contentful_model'
require_relative '../minitest_helper'
