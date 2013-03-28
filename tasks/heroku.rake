
namespace :heroku do

  desc "stage the chosen branch"
  task :deploy, :branch do |t, args|
    branch = args[:branch]
    system "git push -f heroku #{branch}:refs/heads/master"
  end

end
