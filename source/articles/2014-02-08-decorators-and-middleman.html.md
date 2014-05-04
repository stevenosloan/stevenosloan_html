---

title: "Decorators and Middleman"
date: 2014/02/08
draft: true

---

a mix of "custom" resource types, proxied indexes, and plain-ol documents. all to be wrapped into a json endpoint for search.

conditional here, conditional there -- this is where a decorator really shines. take the logic out of your views and put them into the decorator.

had not thought of doing this with a static generator like [Middleman](http://middlemanapp.com)

doing so is really quite simple

```ruby
# my_decorator.rb
require "delegate"

class MyDecorator < SimpleDelegator

  def resource
    __getobj__
  end

  def title
    resource.data.title ||  resource.metadata.fetch(:page, {}).fetch(:title, "")
  end

end
```

```haml
# view.html.haml
- resource = MyDecorator.new(current_resource)

%article
  %h1= resource.title
```
.

perhaps a "better" use example would be with a partial that you'd like to share between a few different resource types

```ruby
```