class ZIG::Formatter

  INDENT = "   "

  def self.print_hash(indent, hash)
    print "{\n"
    indent = indent + INDENT
    hash.each do |key, value|
      print indent + key.to_s + ": "
      print_value(indent, value)
    end
  end

  def self.print_array(indent, array)
    print "[\n"
    indent = indent + INDENT
    array.each do |v|
      print indent
      print_value(indent, v)
    end
  end

  def self.print_multiline_string(indent, string)
    print "\"\n"
    indent = indent + INDENT
    string.split("\n").each do |line|
      print indent + line.lstrip + "\n"
    end
  end

  def self.print_value(indent, value)
    case value
    when Hash then print_hash(indent, value)
    when Array then print_array(indent, value)
    when String
      if value.include?("\n")
        print_multiline_string(indent, value)
      else
        print "'#{value}'\n"
      end
    else print value.inspect + "\n"
    end
  end

end