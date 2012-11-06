Dependencies
------------

- [RVM](https://rvm.io) with Ruby 1.9.3
- [Bundler](http://gembundler.com/) 1.2+
- [Editor Config](https://github.com/editorconfig/)



Initial Install
---------------

```bash
$ bundle install
```


Rake Tasks
----------

```bash
$ rake server
# => kickoff preview server

$ rake stage["branch_name"]
# => push the specified branch to staging

$ rake build
# => build the static site

$ rake deploy
# => deploy the built site to production
```