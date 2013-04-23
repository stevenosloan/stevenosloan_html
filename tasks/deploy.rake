require 'statistrano'

define_deployment "production", :releases do |config|

  config.remote = 'digitalocean'
  config.build_task = 'middleman:build'
  config.local_dir = 'build'
  config.remote_dir = '/var/www/stevenosloan.com'
  config.git_branch = 'master'

end