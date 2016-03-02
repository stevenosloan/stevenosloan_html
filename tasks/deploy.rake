require 'statistrano'

production = define_deployment 'production', :releases do
  hostname   'stevenosloan.com'

  local_dir  'build'
  remote_dir '/var/www/stevenosloan.com'

  check_git  true
  git_branch 'master'

  build_task 'middleman:build'

end
production.register_tasks
