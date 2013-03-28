require 'statistrano'

define_server "production" do
  set :remote, 'digitalocean'
  set :project_root, "/var/www/stevenosloan.com"
end