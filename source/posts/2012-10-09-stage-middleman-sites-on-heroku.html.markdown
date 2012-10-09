---
title: Heroku as a staging environment for static generators
date: 2012/10/09
---

I’m often finding myself wanting to stage something to either show somebody quickly (and don’t feel like waiting for a build), or test it in a few browsers or devices.

The asset hashing of sprockets is greate, but after constantly switching feature branches and getting merge errors in only the built files. 

set up what is essentially a “testing” server and reserve the “staging” server for big builds or features that require the use of PHP.


In this case we’re using Middleman, so depending on your project things may be a little different, but we’ll need to do a couple things to get the Middleman server running on Heroku.

1. add a `config.ru` file to tell rack how to run the app
2. add thin and foreman to our gemfile
3. add a Procfile to tell heroku how to start the app
4. move any development only gems to the development group (livereload in this example)

```
# Gemfile
gem “thin”
gem “foreman”
gem "middleman-livereload", :group => :development

# Procfile
web: bundle exec thin start -R config.ru -p $PORT

# config.ru
require 'rubygems'
require 'middleman'

run Middleman.server
```
You can use the foreman gem to simulate the heroku environment on your machine - just run `foreman start` and the app should mount on port 5000.

## Wait, wasn’t the goal testing feature branches?

You caught me, without a little more work all we’d have is the master branch running on heroku.

The standard way you would push to heroku would be with `git push heroku`, but that pushes the master branch to heroku – not what we want in this case. That’s ok though, we can push a specific feature branch and indicate that we want it to be the master branch on the heroku repo `git push -f heroku #{branch}:refs/heads/master`, but to make things easier, a little rake task.
```
desc "stage the chosen branch"
task :stage, :branch do |t, args|
  branch = args[:branch]
	system "git push -f heroku #{branch}:refs/heads/master"
end
```
For example to stage the `foo` branch you’d call  `rake stage[foo]`