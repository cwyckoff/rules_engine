require 'spec_helper'

describe Equals do

  describe "#satisfied_by?" do

    let(:args) { ["Barry"] }
    let(:condition) { Equals.new(*args) }

    context "params pass condition" do

      it "returns true" do
        condition.satisfied_by?("Barry").should be_true
      end


    end

    context "params fail condition" do

      it "returns false" do
        condition.satisfied_by?("Sue").should be_false
      end


    end

  end

end
