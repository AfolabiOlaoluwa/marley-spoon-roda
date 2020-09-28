# frozen_string_literal: true

class App
  hash_routes.on 'index' do |_|
    set_view_subdir 'index'
  end
end
