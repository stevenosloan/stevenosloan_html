namespace :middleman do

	task :build do
	  system "bundle exec middleman build --clean"
	end

	task :server do
	  system "bundle exec middleman server"
	end

  desc "run in 'diff' mode that disables dynamic/random content"
  task :diff do
    ENV['BUILD_ENV'] = "diff"
    Rake::Task["middleman:build"].invoke

    puts "========================="
    puts "running diff against build.original/"
    puts "output:"
    puts `diff -rq build/ build.original/`
  end

  desc "sets up our 'master' build for diffing"
  task :diff_original do
    ENV['BUILD_ENV'] = "diff"
    Rake::Task["middleman:build"].invoke

    puts "========================="
    puts "moving build to build.original"
    puts `mv build/ build.original/`
  end

end