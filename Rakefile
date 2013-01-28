require 'colorize'

# Add ./lib to the load path
$LOAD_PATH << File.join( Dir.pwd, '/lib' )

# Import namespaces from /tasks
Dir.glob('tasks/*.rake').each { |r| import r }


task :server do
  Rake::Task["middleman:server"].invoke
end

task :build do
	Rake::Task["middleman:build"].invoke
end

desc "stage the chosen branch"
task :stage, :branch do |t, args|
  branch = args[:branch]
	system "git push -f heroku #{branch}:refs/heads/master"
end
