require 'twitter_cldr'

class Formatters < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def datetime_ago(datetime)
      datetime.localize.ago.to_s
    end
  end
end

::Middleman::Extensions.register(:formatters, Formatters)

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
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

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :formatters

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'

set :layouts_dir, 'layouts'
set :partials_dir, 'shared'

set :markdown_engine, :kramdown
set :markdown, smartypants: true

# Pretty URLs
activate :directory_indexes

# Thumbnail generator
require 'middleman-thumbnailer'
activate :thumbnailer, 
  :dimensions => {
    :lg => '192x',
    :md => '352x',
    :sm => '384x',
    :xs => '480x',
    :lg_2x => '384x',
    :md_2x => '704x',
    :sm_2x => '768x',
    :xs_2x => '960x',
  },
  :include_data_thumbnails => true,
  :namespace_directory => %w(work)

# svg-fallback
require "middleman-svg-fallback"
activate :svg_fallback,
  :inkscape_bin => '/Applications/Inkscape.app/Contents/Resources/bin/inkscape',
  :inkscape_options => '--export-dpi=100 --export-background-opacity=0'

# Deploy
activate :deploy do |deploy|
  deploy.method = :git
  # Optional Settings
  # deploy.remote   = "custom-remote" # remote name or git url, default: origin
  # deploy.branch   = "custom-branch" # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  deploy.build_before = true # default: false
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Minify HTML on build
  activate :minify_html

  # Enable cache buster
  activate :asset_hash, :exts => %w(ico manifest jpg png gif js css)

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  # Gzip for faster site
  activate :gzip

  # activate :imageoptim
end
