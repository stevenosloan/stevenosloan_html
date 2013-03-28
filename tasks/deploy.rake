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