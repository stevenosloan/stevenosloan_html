---

title: Put the shovel down, you might hurt yourself.
date: 2013/03/29
draft: true

---

Recently I was using the shovel operator to concatenate a string and an instance variable exposed with an `attr_reader` for a method to return and noticed an odd thing, the instance variable was being modified – addmittedly I was using the shovel operator wrong – but it prompted me to dig into some unexpected potential pitfalls of using it.

## tl;dr;

Because of how the shovel operator works, by modifying the object it is called on, any method that exposes an object allows that object to be modified by a shovel. This differs from the `+=` operator that returns a new object. Consequentially, any other method that modifies the original object (like `push`) has the same caveat – so exposing an instance variable with a getter and no setter, doesn't mean its safe from modification.

## Modifying instance variables through attr_reader

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


# putting the array and string work
# as we would expect

p thing.arr
# => []

p thing.str
# => ""


# but if we shovel into them, we can
# alter their state -- even though we
# only exposed a getter method

thing.arr << "hello"
p thing.arr
# => ["hello"]

thing.str << "hello"
p thing.str
# => "hello"


# So what if we do define a setter?
# What does the shovel do in that case?

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

# it's important then to watch out what
# you're using the shovel for as it bypasses
# the existing setter methods and directly
# manipulates a bare instance variable if
# it is exposed with a getter.
```