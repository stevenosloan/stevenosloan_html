---
title: Prevent form zooming on the iPhone without disabling user scaling.
date: 2013/06/20
featured: true
---

It's that little no-no that we all (generalizing to make myself feel better) end up doing, adding `user-scalable=no` to viewport meta tags. Forms have a tenancy to cause iOS to zoom, it makes people (designers) a little crazy, and we opt out and add the meta tag to make the problem go away.

Recently, while working on the [MailChimp redesign](http://mailchimp.com), we realized why the forms were zooming. Apple, with good reason, made a decision that when filling out forms on iOS they should appear at a comfortable reading size ~ 1em/16px. To accomplish this they zoom in on the page until that size requirement is met.

By setting our inputs to 1em/16px or higher, the OS no longer zooms and everyone is happy. Check out a [little demo](http://cdpn.io/ulnFr) of differing input sizes to see it in action.

## A little hack

It appears that there is one loophole around this if you *really* want your inputs smaller. By setting the font-size to >= 16px on focus we can keep fields the size we want *until* they're in use. The font-size can't have a transition applied however, so the scalling can feel a bit jumpy.

[Demo](http://cdpn.io/ulnFr)
