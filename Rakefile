desc 'build site'
task :build do

  puts "starting middleman build"
  system "bundle exec middleman build --clean"

end


desc "preview the built site"
task :preview do
  system "cd ./build && python -m SimpleHTTPServer"
end