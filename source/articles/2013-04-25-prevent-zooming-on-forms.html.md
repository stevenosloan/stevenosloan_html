---

title: Prevent form zooming on the iPhone without disabling user scaling.
date: 2013/04/25
draft: true

---

Have a situation where we have a field that zooms in our viewport on iPhone devices, seems like nothing can be done so at the urging of the designers (that could include yourself) you're liable to cave and say, "I know, I can just disable user zooming!". True – you can – but in the interest of a better user experience, we should find another way.

It turns out, iPhone is zooming the viewport to make the form of a comfortably viewable size – 1em/16px. So if we set the font-size of our inputs to 1em/16px or greater, no viewport zooming on the iPhone. Check out [this demo](http://codepen.io/stevenosloan/full/ulnFr) to see some inputs that zoom and some that don't.

## Going Further

here's the trick, we can make our forms behave as we wish (within constraints support) and still not zoom the viewport. We just have to reset the input to our 1em/16px on focus.

there's another way to do it as well, it turns out the font size only needs to be set on focus, so we can turn it into a feature. For our really small fields, increase there size to all of our users -- and for those close to 1em/16px -- shim the field up slightly to avoid zooming on iPhone.

Haml:

```css
/* markup */
%input{ type: "text", placeholder: ".66em til focus" }

/* scss */
input {
  font-size: .66em
  &:focus {
    font-size: 1em;
  }
}
```

[Demo](#)