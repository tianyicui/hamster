require 'spec_helper'

require 'hamster/set'

describe Hamster do

  describe "#flatten" do

    [
      [[], []],
      [["A"], ["A"]],
      [["A", "B", "C"], ["A", "B", "C"]],
      [["A", Hamster.set("B"), "C"], ["A", "B", "C"]],
      [[Hamster.set("A"), Hamster.set("B"), Hamster.set("C")], ["A", "B", "C"]],
    ].each do |values, expected|

      describe "on #{values}" do

        before do
          @original = Hamster.set(*values)
          @result = @original.flatten
        end

        it "preserves the original" do
          @original.should == Hamster.set(*values)
        end

        it "returns an empty set" do
          @result.should == Hamster.set(*expected)
        end

      end

    end

  end

end
