require 'statistrano'

production = define_deployment "production", :releases do
  hostname   'deployer.do.stevenosloan.com'
  build_task 'middleman:build'
  local_dir  'build'
  remote_dir '/var/www/stevenosloan.com'
  check_git  true
  git_branch 'master'
  verbose true
end
production.register_tasks