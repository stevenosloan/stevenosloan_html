# Add ./lib to the load path
$LOAD_PATH << File.join( Dir.pwd, '/lib' )


# Layouts
# ---------------------------------------

page "/feed.xml", layout: false

require 'remove_drafts'
activate :remove_drafts

activate :blog do |blog|
  blog.prefix    = "articles"
  blog.permalink = ":year/:title.html"
  blog.layout    = "article_layout"
end



# Directories
# ---------------------------------------

## Templates
activate :directory_indexes

## Assets
set :css_dir,    'assets/css'
set :js_dir,     'assets/scripts'
set :images_dir, 'assets/images'

## Setup Haml
activate :syntax
set :haml, ugly: true,
           format: :html5,
           hyphenate_data_attrs: false,
           remove_whitespace: true

## Use Redcarpet for Markdown
set :markdown, fenced_code_blocks: true,
               autolink: true,
               smartypants: true,
               with_toc_data: true
set :markdown_engine, :redcarpet

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
end

# Helpers
# ---------------------------------------

require 'a_little_help'
helpers ALittleHelp


# Build-specific config
# ---------------------------------------

configure :build do

  # Change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # Don't give a hash to assets in the static folder
  activate :asset_hash, ignore: %r{^(assets/static/.*)}

end
