ENV["RACK_ENV"] = "test"
require_relative '../../models/recipe'

require_relative '../minitest_helper'

ContentfulModel.configure do |config|
  config.space = ''
  config.access_token = ''
  config.environment = "master"
end

