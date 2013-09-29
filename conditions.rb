class Equals

  def initialize(operand)
    @operand = operand
  end

  def satisfied_by?(param)
    @operand == param
  end

end

class GreaterThan

  def initialize(operand)
    @operand = operand.to_i
  end

  def satisfied_by?(param)
    param.to_i > @operand
  end

end

class LessThan

  def initialize(operand)
    @operand = operand.to_i
  end

  def satisfied_by?(param)
    param.to_i < @operand
  end

end
