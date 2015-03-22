---
title: Middlewareman
date: 2014/12/31
draft: true
---

This is the next generation middleman, and yes, I do feel like an ass for saying it. The hard fact is that this will *not* replace middleman, it accepts a different set of facts than middleman does. Think of it as a sinatra/rails situation. Sinatra provides no boundaries, and in doing so provides no guidance.


At it's base middleware man is nothing, you don't need it to create your site. It naively provides a set of methodology, tools, and interfaces to create a system to build your site. The only `rule` is the `resource` object responding to a few questions (that could be answered false, wether it matters would differ at each step) [`source_file`, `contents`, `destination`], and the app, wich will have a `config` hash (with method access).


at it's base is the statement `pipe` that takes an array of middleware in three steps: `build_tree`, `render`, `output`. To switch between file & server? use different `output` middleware.

Each step has a distinct purpose (and included middleware could fulfill multiple).
  - `build_tree` to add (or subtract) from the `resource_tree`
  - `render` to generate the content of each resource
  - `output` the "exit" of each resource, to a file or port or POST.

For extensibility the app would also react to `before_build_tree`, `after_build_tree`, `before_render`, `after_render`, `before_output`, `after_output`.

All middleware should answer to `call` after `#new(app)` with `resource` and return `Resource`.

The `Resource` should have


```ruby


pipe build_tree: [
  Proc.new(source_dir) do |app, file_tree|
  end,
  Proc.new() do |file_tree|
  end
],
  render: [
  Proc.new(source_file) do |app, source_content, options|
  end
],
  output: [
  Proc.new() do |app, fuck|
  end
]
```


the outer level abstractions

```ruby
# bin/site

app = Middlewareman.new
app.use Foo, Bar, Baz

app.run
```

```bash
$ bin/site build
# => runs with the build output

$ bin/site serve
# => runs with the serve output
```



Implementation:

I will write this in `Clojure` and `Ruby`. *Why?* to learn a bit more in clojure and i want the tool in ruby. Of course the efficiencies will be different in both.

```ruby

class Middlewareman::Resource

  def initialize source_file, source_data={}
  end

end


class Middlewareman::App
  atr_reader: source_path

  def initialize source_path=nil
    @source_path ||= false
  end

  def step!
  end

  def use *args
    # args take build_tree:, render: nil, output:
  end

  private

    def use_build_tree tree
      build_trees.map do |app, tree|
      end
    end

    def use_render resource
      renderers
    end

    def use_output resource
    end

end

```

