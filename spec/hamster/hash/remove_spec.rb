require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Hamster::Hash do

  describe "#remove" do

    describe "with an existing key" do

      before do
        @original = Hamster::Hash.new.put("A", "aye").put("B", "bee")
        @copy = @original.remove("A")
      end

      it "returns a modified copy" do
        @copy.should_not equal(@original)
      end

      describe "the original" do

        it "still has the original key/value pairs" do
          @original.get("A").should == "aye"
          @original.get("B").should == "bee"
        end

        it "still has the original size" do
          @original.size.should == 2
        end

      end

      describe "the modified copy" do

        it "has all but the removed original key/value pairs" do
          @copy.get("B").should == "bee"
        end

        it "doesn't have the removed key" do
          @copy.has_key?("A").should be_false
        end

        it "has a size one less than the original" do
          @copy.size.should == 1
        end

      end

    end

    describe "with non-existing keys" do

      before do
        @original = Hamster::Hash.new.put("A", "aye")
        @copy = @original.remove("missing")
      end

      it "returns self" do
        @copy.should equal(@original)
      end

      describe "the original" do

        it "still has the original key/value pairs" do
          @original.get("A").should == "aye"
        end

        it "still has the original size" do
          @original.size.should == 1
        end

      end

    end

    describe "with keys of the same hash value" do

      class Key
        def hash; 1; end
      end

      def instance_count
        ObjectSpace.garbage_collect
        ObjectSpace.each_object(Hamster::Hash) {}
      end

      before do
        @a = Key.new
        @b = Key.new
        @original = Hamster::Hash.new.put(@a, "aye").put(@b, "bee")
      end
      
      it "no longer provides access to the removed key" do
        copy = @original.remove(@b)
        copy.has_key?(@b).should be_false
      end

      it "provides access to the remaining keys" do
        copy = @original.remove(@a)
        copy.get(@b).should == "bee"
      end

      it "cleans up empty instances" do
        pending do
          instance_count_before = instance_count
          # copy = @original.remove(@b)
          instance_count.should == instance_count_before + 1
        end
      end

    end

  end

end
