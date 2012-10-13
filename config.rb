
###########################
## Layouts
###########################

page "/feed.xml", :layout => false

activate :blog do |blog|

  blog.prefix = "posts"
  blog.permalink = ":year/:title.html"
  blog.layout = "article_layout"

end


###########################
## Directories
###########################

activate :livereload

## Templates
activate :directory_indexes

## Assets
set :css_dir, 'assets/css'
set :js_dir, 'assets/scripts'
set :images_dir, 'assets/images'

## Ignore the source js files
ignore "assets/scripts/src/*"
set :markdown, :fenced_code_blocks => true, :autolink => true, :smartypants => true
set :markdown_engine, :redcarpet

# nasty hack
$Application = self

module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require 'redcarpet'
  def render(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, $Application.markdown).render(text)
  end
end

###########################
## Helpers
###########################

require 'helpers'
helpers CustomHelpers


###########################
## Build-specific config
###########################

configure :build do

  # Change the Compass output style for deployment
  activate :minify_css
  
  # Minify Javascript on build
  activate :minify_javascript
  
  # Enable cache buster
  # Don't give a hash to assets in the static folder
  activate :asset_hash, :ignore => %r{^(assets/static/.*)}
  
  # Use relative URLs
  # activate :relative_assets
  
  # Use a different image path
  # set :http_path, "/Content/images/"

end
