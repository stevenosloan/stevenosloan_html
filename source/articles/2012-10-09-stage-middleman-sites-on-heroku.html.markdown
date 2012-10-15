---
title: Heroku as a staging environment for static generators
date: 2012/10/09
---

At MailChimp we make heavy use of [static site generators](http://blog.mailchimp.com/building-the-new-mailchimp/), which is fantastic. We get to use the latest, shiniest toys developing the sites and still have a stable, blistering fast deployed site.

We have to wait for the site to build with each change though (though we've gotten that down to around 90 seconds so it's not too bad), and often want to stage a feature branch to either show somebody quickly (*will* be making changes and don't feel like waiting for a build), or test it in a few browsers or devices.

So lately I've been thinking it would be great to stage feature branches on heroku and use the same dynamic servers we use to preview on our dev boxes. It turns out that this was really no sweat after getting past a couple pain points.

I'm going to assume you have at least a basic knowledge of running your ruby application and deploying to heroku. So lets dive in.

## Getting Started

At first I thought things might be as simple as adding a Procfile to kickoff the server, but that turned out not to be the case. Heroku needs to understand how to mount the underlying rack app – simple fix though.

In this case I'm using Middleman, so depending on your project things may be a little different, but we’ll need to do a couple things to get the Middleman server running on Heroku.

1. add a 'config.ru' file to tell rack how to run the app
2. add thin and foreman to our gemfile
3. add a Procfile to tell heroku how to start the app

```
# Gemfile
gem "thin"
gem "foreman"

# Procfile
web: bundle exec thin start -R config.ru -p $PORT

# config.ru
require 'rubygems'
require 'middleman'
require 'middleman-blog'

run Middleman.server
```

You might notice the addition of 'middleman-blog' to the config.ru. I'm running the blog engine, so it's necessary to get things working. Once you've made these couple changes you should be able to deploy to heroku and have a working app, YMMV with other apps though. (I'll probably add docs for [frank](https://github.com/blahed/frank) when I get things running for it)

Locally you can use the foreman gem to simulate the heroku environment on your dev machine - just run `foreman start` and the app should mount on port 5000.


## Wait, wasn’t the goal testing feature branches?

You caught me, without a little more work all we'd have is the master branch running on heroku.

The standard way you would push to heroku would be with 'git push heroku', but that pushes the master branch to heroku – not what we want in this case. That's ok though, with a little git magic we can push a specific feature branch and overwrite the master branch on heroku.

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

I included the rake task I use to make this a little easier as well. For example to stage the 'foo' branch you’d call  'rake stage[foo]'