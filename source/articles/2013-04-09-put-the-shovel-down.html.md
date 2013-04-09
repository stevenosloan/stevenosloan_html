---

title: Put the shovel down, you might hurt yourself.
date: 2013/04/09

---

Recently I was using the shovel operator to concatenate a string and an instance variable exposed with an `attr_reader` to be returned by a method and noticed an odd thing, the instance variable was being modified – admittedly I was using the shovel operator incorrectly – but it prompted me to dig into some unexpected potential pitfalls of their use.

## tl;dr;

In Ruby there is a convention to end methods that are dangerous (like mutate the object they are called on) with an `!`, for example `gsub!`, `map!`, or `capitalize!`. This isn't always the case though, so some unexpected situations can crop up if you're not careful.

Because of how the shovel operator works, and other methods that mutate the object they're called on, any method that exposes an object allows that object to be modified. So contrary to what you might expect, exposing an instance variable with a getter and no setter, doesn't mean its safe from modification. And having a getter doesn't guarantee that you're able to control how a variable is set.

## Modifying instance variables through attr_reader

To demonstrate, we'll take a few instance variables exposed only with getters, and modify them. To do so, lets create a class with an instance variable containing an array and a string and initialize it.

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

You may expect to be able to control how a variable is defined through a getter, but that is not the case with shovels (or other methods that mutate the object they're called on).

```ruby
class Thing2 < Thing

  def arr= obj
    @arr = %w{ set it and forget it }
  end

  def static_string
    "I'm not going to change"
  end

end

thing2 = Thing2.new()
p thing2.arr
# => []

thing2.arr = "hello"
p thing2.arr
# => ["set", "it", "and", "forget", "it"]

thing2.arr << "and get burned"
p thing2.arr
# => ["Set", "it", "and", "forget", "it", "and get burned"]

p thing2.static_string
# => "I'm not going to change"

thing2.static_string << " or am I?"
p thing2.static_string
# => "I'm not going to change"
```

A gist with all the code is available [here](https://gist.github.com/stevenosloan/5145549), please don't hesitate to comment there if you have something to add.