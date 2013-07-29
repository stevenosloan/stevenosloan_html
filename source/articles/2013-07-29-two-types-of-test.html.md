---

title: Two types of test
date: 2013/07/29
draft: true

---


Two developers walk into a bar, and a blog post walks out; or something like that. Recently I had the oportunity to get together with [Loren Norman](https://twitter.com/lorennorman), and we talked about a slew of things. One topic that set out in my mind though was about documentation and how testing fits into that. As we talked the idea surfaced that there could be two "*modes*" of testing, test that ensure behavior or test that document behavior -- on the surface these may seem like the same thing they have their subtle differences.

## Class/Method behavior

The former, 'ensure behavior' is how I've started to prefer writing my tests. This way you are writing what your code accomplishes and there is some room for using different methods/modules/etc within the test. The concern is "what can the code do" and not with the specifics of implementation. Its kind of like a module/class level integration test.

## Method behavior

The other 'document behavior'

This is a contrived example, but one I've seen fairly often (in rspec syntax) -- you describe your class, then proceed to run down the class describing the behavior of each method. I personally find this type of testing to be great for ensuring the code I am writing is doing what I want -- but not so great for describing the goals of each of my classes (hence my preference for writing in the other way). It is however really great for documentation. If the class' public methods haven't been fancied up with nice rdoc comments, specs when written in this way provide just as much information on how those methods can be used.

```ruby
describe Foo do
  describe "#foo" do
    it "returns the string 'foo'" do
      Foo.foo.should == "foo"
    end
  end
  describe "#bar" do
    it "returns the string 'bar'" do
      Foo.bar.should == "bar"
    end
  end
end
```

## For fun and profit?

Following TDD I often write the "method behavior" style of tests first, just to get things going. Then I follow that up factoring my tests into the "class/method behavior" style to keep things more uniform as time goes on.


for the time being I'm playing around with a 'public\_api\_spec' to keep track of that "document behavior" concern, and then running the others to ensure behavior so I can change the underlying structure alot without switching up my tests (or atleast the concerns of my tests) too much. Part of that might be the youth of the gems/projects I'm working on -- so we'll see how it goes into the future.