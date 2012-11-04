require "jmie/version"
require "jmie/lines"
require "jmie/parser"

require "stringio"

module JMIE

  def self.parse(string)
    lines = Lines.new(StringIO.new(string))
    Parser.parse_value(0, lines, lines.next)
  end

end
