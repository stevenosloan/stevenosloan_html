namespace :middleman do

	task :build do
		puts "starting middleman build"
	  system "bundle exec middleman build --clean"
	end

	task :server do
	  system "bundle exec middleman server"
	end

end