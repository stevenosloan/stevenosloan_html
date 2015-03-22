namespace :middleman do

  task :env do
    resp = HereOrThere::Local.new.run 'which node'
    if resp.success?
      puts 'EXECJS_RUNTIME: Node'
      ENV['EXECJS_RUNTIME'] = 'Node'
    end
  end

	task :build => [:env] do
	  system "bundle exec middleman build --clean"
	end

	task :server => [:env] do
	  system "bundle exec middleman server"
	end

end
