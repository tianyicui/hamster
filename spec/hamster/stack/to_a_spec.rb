require 'spec_helper'

require 'hamster/stack'

describe Hamster::Stack do

  [:to_a, :entries].each do |method|

    describe "##{method}" do

      [
        [[], []],
        [["A"], ["A"]],
        [["A", "B", "C"], ["C", "B", "A"]],
      ].each do |values, expected|

        describe "on #{values.inspect}" do

          before do
            @stack = Hamster.stack(*values)
            @result = @stack.send(method)
          end

          it "returns #{expected.inspect}" do
            @result.should == expected
          end

          it "returns a mutable array" do
            @result.last.should_not == "The End"
            @result << "The End"
            @result.last.should == "The End"
          end

        end

      end

    end

  end

end
