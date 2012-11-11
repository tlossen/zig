class ZIG::Lines
  attr_reader :current, :num

  def initialize(file)
    @file, @current, @num = file, file.gets, 1
  end

  def empty?
    @current.nil?
  end

  def next
    @current, @num = @file.gets, @num + 1
  end
end
