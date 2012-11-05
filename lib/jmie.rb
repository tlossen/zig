require "jmie/version"
require "jmie/lines"
require "jmie/parser"

require "stringio"

module JMIE

  def self.parse(string)
    lines = Lines.new(StringIO.new(string))
    start = lines.current || raise("cannot parse empty document")
    lines.next
    Parser.parse_value(0, lines, start)
  end

end
