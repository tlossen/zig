module JMIE
  class Parser

    FULL_LINE = /^( *)(.*)$/
    KEY_VALUE = /^([^:]+):(.*)$/
    STRING    = /^'(.*)'$/
    INTEGER   = /^-?\d+$/
    FLOAT     = /^-?\d+\.\d+([eE][+-]?\d+)?$/

    def self.parse_object(indent, lines, object)
      loop do
        return object if lines.empty?
        spaces, value = lines.current.scan(FULL_LINE).flatten
        return object if spaces.size < indent
        raise "[line #{lines.num}] illegal indent" if spaces.size > indent
        lines.next
        if object.is_a?(Hash)
          key, value = value.scan(KEY_VALUE).flatten
          raise "[line #{lines.num}] missing key" if key.nil?
          object[key.strip.to_sym] = parse_value(indent, lines, value)
        elsif object.is_a?(Array)
          object << parse_value(indent, lines, value)
        else
          object << "\n" unless object.empty?
          object << value
        end
      end
    end

    def self.parse_value(indent, lines, text)
      text = text.strip
      case text
      when 'nil'   then nil
      when 'true'  then true
      when 'false' then false
      when '{'     then parse_object(indent + 3, lines, {})
      when '['     then parse_object(indent + 3, lines, [])
      when '"'     then parse_object(indent + 3, lines, "")
      when STRING  then $1
      when INTEGER then text.to_i
      when FLOAT   then text.to_f
      else
        raise "[line #{lines.num}] illegal value: #{text}"
      end
    end

  end
end