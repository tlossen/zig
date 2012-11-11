class ZIG::Formatter

  INDENT = " " * 2

  def self.print_hash(out, indent, hash)
    out.write("{\n")
    indent = indent + INDENT
    hash.each do |key, value|
      out.write(indent + key.to_s + ": ")
      print_value(out, indent, value)
    end
  end

  def self.print_array(out, indent, array)
    out.write("[\n")
    indent = indent + INDENT
    array.each do |v|
      out.write(indent)
      print_value(out, indent, v)
    end
  end

  def self.print_multiline_string(out, indent, string)
    out.write("\"\n")
    indent = indent + INDENT
    string.split("\n").each do |line|
      out.write(indent + line.lstrip + "\n")
    end
  end

  def self.print_value(out, indent, value)
    case value
    when Hash then print_hash(out, indent, value)
    when Array then print_array(out, indent, value)
    when String
      if value.include?("\n")
        print_multiline_string(out, indent, value)
      else
        out.write("'#{value}'\n")
      end
    else out.write(value.inspect + "\n")
    end
  end

end