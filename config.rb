
###########################
## Layouts
###########################

## default
page "*", :layout => :default



###########################
## Directories
###########################

## Templates
activate :directory_indexes

## Assets
set :css_dir, 'assets/css'
set :js_dir, 'assets/scripts'
set :images_dir, 'assets/images'

## Ignore the source js files
ignore "assets/scripts/src/*"



###########################
## Helpers
###########################

helpers do

  def versioned_script( script_name )
    tag = javascript_include_tag "#{script_name}"
    tag.gsub('<script src="', '' ).gsub('" type="text/javascript"></script>', '' )
  end

  def render_partial( partial_name )
    partial "partials/#{partial_name}"
  end

end



###########################
## Misc
###########################


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
