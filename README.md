# ZIG

ZIG is a simple data format. It is designed to be easily edited by hand.
It is also pretty easy to parse and generate, though.

ZIG is indentation-based, like Python or Coffeescript.

Here is a short example:

```
{
  type: 'error'
  color: {
    r: 255
    g: 192
    b: 0
  description: "
    Check your Internet connection. Restart any router, modem,
    or other network devices you may be using.
  # TODO: do we need these any more?
  codes: [
    118
    192
```
