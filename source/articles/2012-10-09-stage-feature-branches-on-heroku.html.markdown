---
title: Stage Feature Branches on Heroku
date: 2012/10/09
---

At MailChimp we make heavy use of [static site generators](http://blog.mailchimp.com/building-the-new-mailchimp/), which is fantastic. We get to use the latest, shiniest toys developing the sites and still have a stable, blistering fast deployed site.

Often we're building out new pages or trying out new layouts and need to stage them. Heroku provides a nice quick way to stage an app, but only builds the master branch by default. There's an easy way around this pushing the current branch as master, but a short rake task makes this even easier.

```
# Push master to master
$ git push heroku

# Push a feature branch to master
$ git push -f heroku #{branch}:refs/heads/master

# Rakefile
desc "stage the chosen branch"
task :stage, :branch do |t, args|
  branch = args[:branch]
  system "git push -f heroku #{branch}:refs/heads/master"
end
```