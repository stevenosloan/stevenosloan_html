require 'colorize'

desc 'build site'
task :build do

  puts "starting middleman build"
  system "bundle exec middleman build --clean"

end


desc "run middleman server"
task :server do
  
  system "bundle exec middleman server"

end


desc "preview the built site"
task :preview do
  
  system "cd ./build && python -m SimpleHTTPServer"

end

desc "stage the chosen branch"
task :stage, :branch do |t, args|
  branch = args[:branch]
	system "git push -f heroku #{branch}:refs/heads/master"
end

desc "deploy to prod"
task :deploy do

  require 'net/ssh' 
  require 'net/ssh/simple'

  @host = 'stevenosloan_html'
  @location = 'webapps/stevenosloan_html'

  puts "Attempting to connect to production..."
  begin
    Net::SSH::Simple.sync do

      session = ssh @host, "cd #{ @location } && git pull --rebase"
      if session.success
        puts "deploy executed".colorize( :green )
        puts session.stdout
      end

    end
  rescue Net::SSH::Simple::Error => e
    puts "Something bad happened!".colorize(:red)
    puts e          # Human readable error
    puts e.wrapped  # Original Exception
    puts e.result   # Net::SSH::Simple::Result
  end

end
