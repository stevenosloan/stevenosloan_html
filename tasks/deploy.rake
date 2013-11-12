require 'statistrano'

define_deployment "production", :releases do
  remote     'digitalocean'
  build_task 'middleman:build'
  local_dir  'build'
  remote_dir '/var/www/stevenosloan.com'
  check_git  false
  git_branch 'master'
end