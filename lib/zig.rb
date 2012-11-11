require "zig/version"
require "zig/lines"
require "zig/parser"
require "zig/formatter"
require "zig/syntax_error"

require "stringio"

module ZIG

  def self.parse(string)
    lines = Lines.new(StringIO.new(string))
    Parser.parse_document(lines)
  end

  def self.generate(data)
    out = StringIO.new
    Formatter.print_value(out, "", data)
    out.rewind
    out.read
  end

end
