require "zig/version"
require "zig/lines"
require "zig/parser"
require "zig/formatter"

require "stringio"

module ZIG

  def self.parse(string)
    lines = Lines.new(StringIO.new(string))
    Parser.parse_document(lines)
  end

  def self.print(data)
    Formatter.print_value("", data)
  end

end
