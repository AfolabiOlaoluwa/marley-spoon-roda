# frozen_string_literal: true

ContentfulModel.configure do |config|
  config.space = ENV.fetch('CONTENTFUL_SPACE_ID')
  config.access_token = ENV.fetch('CONTENTFUL_ACCESS_TOKEN')
end
