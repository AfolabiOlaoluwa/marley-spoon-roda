require './.env' if File.exist?(".env.rb")
require './config/initializers/contentful_model'
require 'roda'
require './models/recipe'
require 'tilt/sass'

class App < Roda
  opts[:check_dynamic_arity] = false
  opts[:check_arity] = :warn

  plugin :default_headers,
         'Content-Type'=>'text/html',
         'Strict-Transport-Security'=>'max-age=16070400;',
         'X-Frame-Options'=>'deny',
         'X-Content-Type-Options'=>'nosniff',
         'X-XSS-Protection'=>'1; mode=block'

  plugin :content_security_policy do |csp|
    csp.default_src :none
    csp.style_src :self, 'https://maxcdn.bootstrapcdn.com'
    csp.script_src :self
    csp.connect_src :self
    csp.img_src :self
    csp.font_src :self
    csp.form_action :self
    csp.base_uri :none
    csp.frame_ancestors :none
    csp.block_all_mixed_content
  end

  plugin :route_csrf
  plugin :flash
  plugin :assets, css: 'recipe.scss', css_opts: {style: :compressed, cache: false}, timestamp_paths: true
  plugin :render, escape: true, layout: './layout'
  plugin :view_options
  plugin :public
  plugin :hash_routes

  logger = if ENV['RACK_ENV'] == 'test'
             Class.new{def write(_) end}.new
           else
             $stderr
           end
  plugin :common_logger, logger

  plugin :not_found do
    @page_title = "File Not Found"
    view(:content=>"")
  end

  if ENV['RACK_ENV'] == 'development'
    plugin :exception_page
    class RodaRequest
      def assets
        exception_page_assets
        super
      end
    end
  end

  plugin :error_handler do |e|
    case e
    when Roda::RodaPlugins::RouteCsrf::InvalidToken
      @page_title = "Invalid Security Token"
      response.status = 400
      view(:content=>"<p>An invalid security token was submitted with this request, and this request could not be processed.</p>")
    else
      $stderr.print "#{e.class}: #{e.message}\n"
      $stderr.puts e.backtrace
      next exception_page(e, :assets=>true) if ENV['RACK_ENV'] == 'development'
      @page_title = "Internal Server Error"
      view(:content=>"")
    end
  end

  plugin :sessions,
         key: '_App.session',
         cookie_options: {secure: ENV['RACK_ENV'] },
         secret: ENV.send((ENV['RACK_ENV'] == 'development' ? :[] : :delete), 'APP_SESSION_SECRET')

  Unreloader.require('routes') {}

  hash_routes do
    view '', 'index'
  end

  route do |r|
    @recipes = Recipe.all_recipes

    r.public
    r.assets
    check_csrf!
    r.hash_routes('')

    r.get String do |id|
      @recipe_details = Recipe.find_recipe(id)

      next unless @recipe_details
      view 'show'
    end
  end
end