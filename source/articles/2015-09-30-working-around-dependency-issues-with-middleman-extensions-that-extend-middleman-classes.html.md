---
title: Working around dependency issues with Middleman extensions that require Middleman classes
date: 2015/09/30
---

Recently a coworker and I were puzzling over an interesting issue when testing a [Middleman](http://middlemanapp.com) extension. The extension was simple enough adding a `sitemap.xml` resource to the sitemap, however the `sitemap.xml` was added as a class that extended from `Middleman::Sitemap::Resource`. And that's where our problem came from. Our extension ran fine in any projects we added it to, but any time we were ran tests we would hit an error `uninitialized constant Middleman::Sitemap (NameError)`.

[Skip ahead to tl;dr;](#tl;dr;)

To explain the issue and how to resolve it, lets look at a simplified test case. We're going to create an extension that creates a duplicate of the first sitemap resource, but appends 'our_resource/' to the front of the path and creates that resource as the class `OurExtension::Resource`.

To start, the *broken* version of the extension:

```ruby
# our_extension.rb
class OurExtension < ::Middleman::Extension

  def manipulate_resource_list resources
    # grab the first resource
    first_resource = resources.first

    # create a new resource, but add 'our_resource' to the front of the path
    new_resource   = OurExtension::Resource.new( first_resource.store, File.join( 'our_resource', first_resource.path ), first_resource.source_file )

    # add metadata to the resource to make the specs easier later
    new_resource.add_metadata find_you_later: true

    resources + [ new_resource ]
  end

  class Resource < ::Middleman::Sitemap::Resource
  end

  ::Middleman::Extensions.register(:our_resource, OurExtension)
end
```

Then a quick spec that tests that the sitemap includes a resource of the type `OurExtension::Resource`:

```ruby
# spec/spec_helper.rb
require 'rspec'
require 'middleman'

require 'our_extension'

# spec/our_extension_spec.rb
require 'spec_helper'

describe OurExtension

  before :each do
    # please pretend these exist and initialize the app in a good state
    Given.fixture 'base'
    @mm = Middleman::Fixture.app
    @extension = @mm.extensions[:our_extension]
  end

  after :each do
    Given.cleanup!
  end

  it "adds a resource to the sitemap" do
    expect(
      @mm.sitemap.resources.find { |r| r.metadata.keys.include(:find_you_later) }
    ).to be_a OurExtension::Resource
  end

end
```

Sigh. When we try and run our spec we'll raise the error `uninitialized constant Middleman::Sitemap`. Why is this happening? It comes down to [this one line](https://github.com/middleman/middleman/blob/v3-stable/middleman-core/lib/middleman-core.rb#L12). Middleman is autoloading `Middleman::Application`, the class/file that then requires the `Middleman::Sitemap` module. **But** that doesn't happen until we try and initialize an application. For our test cases, we're requiring our extension **before** initializing an application -- so Middleman isn't setup yet.

Luckily, there is little known workaround for this -- use the block syntax for registering an extension. This creates a block that doesn't get executed until the extension is actually activated, which is great for expensive operations -- but also allows us to defer creating classes that extend from Middleman. So, lets move the `OurExtension::Resource` class to a different file (`our_extension/resource.rb`) and change the registration syntax of our extension:

```ruby
# our_extension.rb
class OurExtension
  # ...
end

::Middleman::Extensions.register :our_extension do
  require_relative 'our_extension/resource'
  OurExtension
end

# our_extension/resource.rb
class OurExtension

  class Resource < ::Middleman::Sitemap::Resource
  end

end
```

And boom, things work as expected. For us, this was a case I was very happy I'd been keeping track of [issues for middleman](https://github.com/middleman/middleman/issues) and happened to remember one [about block syntax registration](https://github.com/middleman/middleman/issues/1192) -- I hope you found it helpful as well.

If you'd like to check out a full example w/ those tease about support classes there's an example repo [here](https://github.com/stevenosloan/middleman-test). Please feel free to open an issue there or on [this site's repo](https://github.com/stevenosloan/stevenosloan_html) if something isn't clear.

## tl;dr;

No matter how simple things are -- if you need to extend from a middleman class or module in your extension, it's best to split that out into a different file from your main extension. Then use the [block format](https://github.com/stevenosloan/middleman-test/blob/master/lib/middleman/test/extension.rb#L21-L24) for registering your extension to require those classes. Check out an example of using that alongside some tests in [this repo](https://github.com/stevenosloan/middleman-test).
