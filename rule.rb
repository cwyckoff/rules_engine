class UndefinedConditionError < Exception; end

module Composable

  def and(other)
    And.new(self, other)
  end

  def or(other)
    Or.new(self, other)
  end

end


class Rule
  attr_reader :key, :operator, :operand
  include Composable

  def self.ensure(key)
    Rule.new(key)
  end

  def initialize(key)
    @key = key
  end

  def method_missing(method, *args)
    begin
      @condition = method.to_s.camelize.constantize.new(*args)
      self
    rescue NoMethodError
      raise UndefinedConditionError, "Unable to find Condition for #{method.to_s}"
    end
  end

  def satisfied_by?(params)
    @condition.satisfied_by?(params[@key])
  end

end


class And
  include Composable

  def initialize(one, other)
    @one, @other = one, other
  end

  def satisfied_by?(params)
    @one.run(params) && @other.run(params)
  end

end


class Or
  include Composable

  def initialize(one, other)
    @one, @other = one, other
  end

  def satisfied_by?(params)
    @one.run(params) || @other.run(params)
  end

end
