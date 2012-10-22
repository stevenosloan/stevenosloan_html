---
title: When PHP and Middleman need to be friends
date: 2012/10/20
---

We can't *always* use the new shiny toys, and sometimes the new toys even need to play nice with the old dusty ones. This happens even more often (it seems) when using a ruby static site generator (be it [frank](https://github.com/blahed/frank), [middleman](http://middlemanapp.com/), [nesta](http://nestacms.com/), whatever), the intended purpose is to generate static .html files and deploy them to be served via ngnix, apache, w/e - but sometimes we need at least a *little* bit of server side code to be run, like on contact forms, and PHP is the most ubiquitous/cheap tech to do that with.

I'll walk through my process of getting PHP to play nice with [middleman](http://middlemanapp.com), so YMMV on other generators but the principles should be the same.

## Setting things up

As always, a couple things are required to get started.

- Add [rack-legacy](https://github.com/eric1234/rack-legacy) and [rack-rewrite](https://github.com/jtrupiano/rack-rewrite#readme) to your gemfile and install them
- Install php with the cgi extension, [this homebrew formula](https://github.com/josegonzalez/homebrew-php) makes it easy


```
## ./config.rb
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
	    	return rack_env['PATH_INFO']
	    end
	  }

	end

	use Rack::Legacy::Php, Dir.pwd

end
```

Basic flow here is saying: If the .php file is in the source - use that. Otherwise look for a php file in the build directory, if it's there, build that file and server it. If it's in neither place, let middleman's server do its thing.

It's not ideal as you have to wait for a build to see those pages and at least on this setup (with directory indexes on) it only works with index.php files. Big upside though, those pages making use of php (even the ones using templates) are served with the preview server, and forms/etc can post to them. 

I'm definitely looking to improve the process, so look for updates in the future.