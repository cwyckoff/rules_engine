require 'spec_helper'

describe RulesEngine do

  describe "rules engine functionality" do

    # params:
    # {:name => "Bobby", "age" => 27, "zip" => "84121"}
    xit "records rules for processing later" do
      # given
      RulesEngine.register do |e|
        # simple rule
        e[:name] = Rule.ensure(:name).equals("Barry")

        # Composite rules
        age1 = Rule.ensure(:age).greater_than(50)
        age2 = Rule.ensure(:age).less_than(80)

        e[:num] = age1.and(age2)
        end

      # expect
      # {:name => "Barry", :number => 100}
      RulesEngine[:name].run(:name => "Barry").should be true
      RulesEngine[:name].run(:name => "Sue").should be_false

      RulesEngine[:num].run(:number => 19).should be_false
      RulesEngine[:num].run(:number => 200).should be_false
      RulesEngine[:num].run(:number => 51).should be_true
      RulesEngine[:num].run(:number => 75).should be_true

      # RulesEngine.run_all
    end
  end
end
