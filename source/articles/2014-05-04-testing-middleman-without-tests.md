---
title: Testing Middleman updates without tests
date: 2014/05/04
featured: true
---

Here's a little secret, I have written a few [Middleman](http://middlemanapp.com/) sites without proper test coverage. Even worse, they started out on version 3.0, got bumped to 3.1, and then 3.2 without good coverage.

Now that I've got that off my chest, I'm hoping that perhaps you're in a similar situation. You've gotten a start with Middleman (or any other static site generator really) without tests and fear the upgrade path. Without a good testing suite you could easily be bitten by changes like those that came in [Middleman 3.3.0](https://github.com/middleman/middleman/blob/v3-stable/CHANGELOG.md#330-332) that caused blocks from views to produce no output as they had previously. The change generated no error, but caused portions (or entire layouts) not to be output.

Luckily for me, we had just started using a diff based test that caught the change. At is essence we run a build & then test for differences after making a change. Hopefully this technique will help you cover some of the edges of your codebase.

## Setting up an environment for testing

Testing with diffs requires that we remove any dynamic or random components between builds. For us at MailChimp, that primarily meant turning off freddie's jokes in the source code. It could mean any lorem generators or lists that are sorted in a random order. In the context of middleman specifically, I also disabled asset_hashing & minification as any framework updates could create minor differences that I wanted to pinpoint closer to the source.

Using a `BUILD_ENV` environment variable, my changes to a middleman config would look something like this:

```ruby
# config.rb
configure :build do

  unless ENV['BUILD_ENV'] == 'diff'
    activate :minify_javascript
    activate :minify_css
    activate :asset_hash
  end

end
```

Once a diff env is setup we'll run a "base" build and move it to a safe location `build.original`. You can verify that your diff environment is setup properly by running the diffs again, but we'll cover that later.

With the "base" build in a backup location, we can start hacking at any changes that we want to test against. If you've kept the backup location outside of anything tracked with git, this can be as straightforward as checking out a new branch with the changes.


## Running the diffs

We'll be using the unix [diff](http://unixhelp.ed.ac.uk/CGI/man-cgi?diff) tool to look at our changes, so make sure you've got that installed.

To cover the case of a fast success or failure, the first diff I run is with a condensed output.

```bash
$ diff -rq build.original/ build/
```
This way I can tell at a quick glance what has and hasn't changed. The `-r` argument tells diff to run recursively, while `-q` (or `--brief`) will only list the changed files. So running the test will produce an output like this:

```bash
Only in build/articles: 2014
Files build/articles/index.html and build.original/articles/index.html differ
Files build/feed.xml and build.original/feed.xml differ
Files build/index.html and build.original/index.html differ
```

Now that we've established that some of our files differ, we can take a closer look at *how* they differ. To do this we'll change the output argument that we pass to diff. Previously we had used `-q`, now we'll use `-u` (or `--unified`) to display an output we (well, at least I am) used to from using git. This will give us the differences between each file with a few lines of context.

```bash
$ diff -ru build.original/ build/
```

To me, this output is a little hard to read -- so I use [colordiff](http://www.colordiff.org/) to augment the output with color to show the differences. The interface is the same as diff, but with a colorized output. You may prefer something else though, so I encourage you to look through the [man page](http://unixhelp.ed.ac.uk/CGI/man-cgi?diff) for other options that may suite you better.


## Doh, but it doesn't ...

You're absolutely right, we're not actually testing our production environment. This is just a quick way to make sure we don't have any horrid changes in our built output. If there's any problems caused by updated compressors or the `asset_hash` extension it won't be caught. So you should still test the production output as well as you can.

Hopefully you'll find this helpful in catching some of the worst unexpected behaviors that can crop up from updating Middleman or other dependencies.
