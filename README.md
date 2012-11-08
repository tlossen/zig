# ZIG

Zig is a simple data format. It is designed to be edited by hand.
It is also pretty easy to parse and generate, though.
You can think of Zig as an alternate, indentation-based
syntax for JSON.

Here is a short example that shows all data structures:

```
{
  type: 'error'
  subtype: nil
  description: "
    Check your Internet connection. Restart any router, modem,
    or other network devices you may be using.
  color: {
    r: 255
    g: 192
    b: 0
  # TODO: do we need these any more?
  flags: [
    true
    false
    true
```

In order of appearance: hash, string, nil, multiline string, number,
comment, list, boolean.
