class RulesEngine

  def self.register
    yield self
  end

  def self.[]=(key, rule)
    ruleset[key] = rule
  end

  def self.[](key)
    ruleset[key]
  end

  def self.ruleset
    @ruleset ||= {}
  end
  
end
