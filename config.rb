# Add ./lib to the load path
$LOAD_PATH << File.join( Dir.pwd, '/lib' )

activate :syntax
set :haml, { ugly: true, format: :html5 }

# Layouts
# ---------------------------------------

page "/feed.xml", :layout => false
page "/_lib/*", :layout => false

activate :blog do |blog|

  blog.prefix = "articles"
  blog.permalink = ":year/:title.html"
  blog.layout = "article_layout"

end


# Directories
# ---------------------------------------

require 'middleman-livereload'
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



# PHP on Rack
# ---------------------------------------

unless self.build?

	source_dir = File.join( Dir.pwd, 'source' )
	build_dir = File.join( Dir.pwd, 'build' )

	require 'rack'
	require 'rack-legacy'
	require 'rack-rewrite'

	use Rack::Rewrite do
	  rewrite %r{(.*/$)}, lambda {|match, rack_env|

			## if the file exists in source, serve it
			if File.exists?( File.join( source_dir, rack_env['PATH_INFO'], 'index.php' ) )
				return File.join( 'source', rack_env['PATH_INFO'] + 'index.php' )

			## else if it only exists in build, build it
			elsif File.exists?( File.join( build_dir, rack_env['PATH_INFO'], 'index.php' ) )

				## remove the leading '/' from name
				file = File.join( rack_env['PATH_INFO'], 'index.php' )
				file[0] = ""

				## build the requested file
				puts "building: #{File.join( 'build', rack_env['PATH_INFO'], 'index.php' )}"
				%x[ middleman build -g #{file} ]

				## pass the path on
				return File.join( 'build', rack_env['PATH_INFO'], 'index.php' )

			## else it's an html file, so pass that on
			else
				return rack_env['PATH_INFO'] + 'index.html'
			end
	  }

	end

	use Rack::Legacy::Php, Dir.pwd

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
  activate :asset_hash, :ignore => %r{^(assets/static/.*)}

  # Use relative URLs
  # activate :relative_assets

  # Use a different image path
  # set :http_path, "/Content/images/"

end
