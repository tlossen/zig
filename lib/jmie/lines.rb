module JMIE
  class Lines
    def initialize(file)
      @file, @line, @num = file, file.gets, 1
    end

    def empty?
      @line.nil?
    end

    def current
      @line
    end

    def num
      @num
    end

    def next
      prev, @line, @num = @line, @file.gets, @num + 1
      prev
    end
  end
end
