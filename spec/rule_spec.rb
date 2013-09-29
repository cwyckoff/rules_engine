require 'spec_helper'

describe Rule do

  describe ".ensure" do

    it "returns a Rule object" do
      Rule.ensure(:name).should be_an_instance_of(Rule)
    end

    it "stores param key" do
      # when
      rule = Rule.ensure(:name)

      # expect
      rule.key.should == :name
    end

  end

  describe "#method_missing" do

    context "condition is undefined" do

      it "raises UndefinedConditionError"

    end

  end

  describe "#satisfied_by?" do

    let(:rule) {
      Rule.ensure(:name).equals("Barry")
    }

    context "parameters satisfy rule" do

      it "returns true" do
        rule.satisfied_by?(:name => "Barry", :age => 30, :state => "UT", :email => "foo@bar.com").should be_true
      end

    end

    context "parameters fail rule" do

      it "returns false" do

      end

    end
  end


  describe "#and" do

    it "composes existing rule with another rule" do
      # given
      rule1 = Rule.ensure(:age).greater_than(20)
      rule2 = Rule.ensure(:age).less_than(30)

      # when
      composite_rule = rule1.and(rule2)

      # expect
      composite_rule.satisfied_by?(:age => 25).should be_true
    end

    it "composes existing rules ad nauseum" do
      # given
      rule1 = Rule.ensure(:age).greater_than(20)
      rule2 = Rule.ensure(:age).less_than(30)
      rule3 = Rule.ensure(:name).equals("Barry")

      # when
      composite_rule = rule1.and(rule2).and(rule3)

      # expect
      composite_rule.satisfied_by?(:age => 25, :name => "Barry").should be_true
    end

  end

end


describe And do

  describe "#satisfied_by?" do

    let(:composite) {
      # given
      rule1 = Rule.ensure(:age).greater_than(20)
      rule2 = Rule.ensure(:age).less_than(30)
      rule1.and(rule2)
    }

    context "one and the other satisfy conditions" do

      it "returns true" do
        composite.satisfied_by?(:age => 25).should be_true
      end
    end

    context "one and the other fails conditions" do

      it "returns false" do
        composite.satisfied_by?(:age => 15).should be_false
      end
    end
  end
end


describe Or do

  describe "#satisfied_by?" do

    let(:composite) {
      # given
      rule1 = Rule.ensure(:age).greater_than(20)
      rule2 = Rule.ensure(:age).less_than(15)
      rule1.or(rule2)
    }

    context "one or the other satisfy conditions" do

      it "returns true" do
        composite.satisfied_by?(:age => 25).should be_true
        composite.satisfied_by?(:age => 14).should be_true
      end
    end

    context "one and the other fails conditions" do

      it "returns false" do
        composite.satisfied_by?(:age => 19).should be_false
        composite.satisfied_by?(:age => 20).should be_false
      end
    end
  end
end
