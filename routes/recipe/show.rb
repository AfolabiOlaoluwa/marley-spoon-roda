class App
  hash_routes.on 'show' do |_|
    set_view_subdir 'show'
  end
end