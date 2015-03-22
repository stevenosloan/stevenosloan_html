# Add ./lib to the load path
$LOAD_PATH << File.join( Dir.pwd, '/lib' )

# Import namespaces from /tasks
Dir.glob('tasks/*.rake').each { |r| import r }


desc 'kickoff middleman preview server'
task :server do
  Rake::Task['middleman:server'].invoke
end
