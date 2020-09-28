# frozen_string_literal: true

dev = ENV['RACK_ENV'] == 'development'

if dev
  require 'logger'
  logger = Logger.new($stdout)
end

require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(subclasses: ['Roda'], logger: logger, reload: dev) { App }
require './models/recipe'
require 'contentful_model'
Unreloader.require('app.rb') { 'App' }
run(dev ? Unreloader : App.freeze.app)

freeze_core = !dev
if freeze_core
  begin
    require 'refrigerator'
  rescue LoadError
    # ignored
  else
    require 'tilt/sass' unless File.exist?(File.expand_path('compiled_assets.json', __dir__))

    # rackup -s Puma
    require 'yaml'
    Gem.ruby

    Refrigerator.freeze_core
  end
end
