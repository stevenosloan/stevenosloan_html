---

title: "Return if I'm not crazy"
date: 2013/06/07
draft: true

---

recently I went on a spree of listening to old [Ruby Rogues](http://rubyrogues.com/) podcasts, ()
from a little digging in the "I wonder why / what do others think" mindset, it doesn't seem like the Ruby community is actually decided on this point. And I'll say, I think I disagree that implicit return are bad -- in fact, many times I think they're the right thing to do.

Maybe I am just crazy, but hear me out.

Thinking of "code as contract" I want it to tell me exactly what it's intending to do. This can be confused in Ruby as there is the implied return, the last object in a method gets spit back out. It's nice sometimes, so in a one-liner `"string"` is functionally equivalent to `return "string"`. But I digress, the real point is that I want code to state its intention, not it's side effect. In Ruby that return is more often than not a side effect, stating a return is a contract to whoever is reading the code later "I'm returning this value". This is important.

to expand on an idea from Sandi Muntz, objects recieve queries or commands -- if a method is a query, use a return to indicate as such. If it's a command, don't return -- hell, add `# @return [Void]` in the comment.