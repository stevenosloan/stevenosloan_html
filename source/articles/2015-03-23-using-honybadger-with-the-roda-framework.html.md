---
title: Using Honybadger with the Roda framework
date: 2015/03/23
featured: true
---

Recently at work–for smaller internal projects–we have been using [Roda](http://roda.jeremyevans.net/) in place of microframeworks like [Sinatra](http://www.sinatrarb.com/) or [Hobbit](https://github.com/patriciomacadden/hobbit). It's been a great experience. Promoting these projects from toy to dependable meant adding error tracking.

[Honeybadger](http://honeybadger.io) is our error tracker of choice, and the integration was pretty straightforward, but it took me some spelunking to get things working.

First pass was setting up the rack middleware per honeybadger's documentation:

```ruby
# server.rb
require 'roda'
require 'honeybadger'

class Server < Roda
  HONEYBADGER_CONFIG = Honeybadger::Config.new

  Honeybadger.start HONEYBADGER_CONFIG
  use Honeybadger::Rack::ErrorNotifier,   HONEYBADGER_CONFIG
  use Honeybadger::Rack::MetricsReporter, HONEYBADGER_CONFIG

  # routes, etc ...
end
```

Which worked great, up until I wanted to show a custom error page. So I added an error handler, and things stopped working. Since Roda's [`error_handler`](http://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/ErrorHandler.html) plugin was catching the exception, it was no longer bubbling up to be caught by honeybadger–so no notification.

A little digging revealed that honeybadger's error notifier will look for some keys in the rack env hash. So if you set them you, the notification will be sent out like expected. When defining your error handler, set `env['honeybadger.exception']` to the exception and the notification will be sent.

```ruby
plugin :error_handler do |e|
  env['honeybadger.exception'] = e
  # call error view, etc ..
end
```

