 # ===========================================
# = Simple JSON to File Storage Feature       =
# =                                           =
# =  THIS IS FOR DEMO PURPOSE ONLY!!!         =
# =                                           =
# =  DO NOT USE IN PRODUCTION CODE!           =
# =                                           =
# = (c) Copyleft 2011 jens alexander ewald.   =
# = http://ififelse.net | github.com/jens-a-e =
 # ===========================================

# Do not forget to activate in your config.rb with 
# activate :simple_json_storage

module Middleman::Features::SimpleJsonStorage
  class << self
    def registered(app)
      # Wenn Daten angefordert wurden
      app.get "/data.json" do
        send_file "source/store/data.json"
      end
      # Wenn Daten gesendet wurden, schreibe sie in die "Datenbank"
      app.post "/data.json" do
        data = params.to_json
        begin
          database = File.new("source/store/data.json", "w")
          success = database.write(data)
          database.close
        rescue
          success = false
        end
        content_type :json
        if success
          status 200
          "{message:'Daten wurden erfolgreich gespeichert.'}"
        else
          status 500
          "{message:'Konnte Daten nicht in Datenbank schreiben.'}"
        end
      end
    end
    alias :included :registered
  end
end

activate :simple_json_storage

###
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Haml
###

# CodeRay syntax highlighting in Haml
# First: gem install haml-coderay
# require 'haml-coderay'

# CoffeeScript filters in Haml
# First: gem install coffee-filter
# require 'coffee-filter'

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

###
# Page command
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Change the CSS directory
# set :css_dir, "alternative_css_directory"

# Change the JS directory
# set :js_dir, "alternative_js_directory"

# Change the images directory
# set :images_dir, "alternative_image_directory"

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
