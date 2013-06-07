---

title: Put the shovel down, you might hurt yourself.
date: 2013/04/09

---

Recently I was using the shovel operator to concatenate a string and an instance variable exposed with an `attr_reader` for use elsewhere and noticed an unexpected thing, the instance variable was being modified – admittedly, I was using the shovel operator poorly – but it prompted me to dig into some unexpected side effects of their use.


## tl;dr;

In Ruby it is convention to end methods that mutate the object they are called on end with an `!`, for example `gsub!`, `map!`, or `capitalize!`. This isn't always the case though, so some unexpected situations can crop up if you're not careful (I'm looking at you `keep_if`).

Because of how the shovel operator works, and other methods that mutate the object they're called on, any method that exposes an object allows that object to be modified. So contrary to what you might expect, exposing an instance variable with a getter and no setter, doesn't mean its safe from modification (ignoring the "devious" meta-programy means of modification).


## Modifying instance variables through attr_reader

To demonstrate, we'll take a few instance variables exposed only with getters, and modify them. To do so, create a class with an instance variable containing an array and a string and initialize it.

```ruby
# create a class with an attr_reader for
# a string and an array
class Thing
  attr_reader :arr
  attr_reader :str

  def initialize
    @arr = []
    @str = ""
  end
end

# initialize the class
thing = Thing.new
```

Putting the array and string return values as we would expect.

```ruby
p thing.arr
# => []

p thing.str
# => ""
```

Now we can see that if we use a shovel with our getter methods, the state of the variables is altered.

```ruby
p thing.arr << "hello"
# => ["hello"]

p thing.arr
# => ["hello"]

p thing.str << "hello"
# => "hello"

p thing.str
# => "hello"
```

If you really need to "ensure" that instance variables aren't inadvertantly modified, you can write a getter with `dup` to return a copy of the original instance.

```ruby
class Protected
  attr_accessor :exposed

  def initialize
    @exposed = "safe"
    @safe = "safe"
  end

  def safe
    @safe.dup
  end
end

# again, a sanity check to see that
# our values both equal "safe"

example = Protected.new
p example.safe == example.exposed
# => true

# we'll shovel to try and modify them
example.exposed << " or not"
example.safe << " or not"

# and test equality again
p example.safe == example.exposed
# => false

# we can see @safe keeps its original value
p example.safe
# => "safe"
```

A gist with all the code is available [here](https://gist.github.com/stevenosloan/5145549), please don't hesitate to comment there if you have something to add.