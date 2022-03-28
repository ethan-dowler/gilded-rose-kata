require_relative "../src/item"

describe Item do
  subject { Item.new(nil, nil, nil) }
  
  describe "#to_s" do
    context "when the item does NOT have a name, sell_in, or quality" do
      it "returns a string" do
        expect(subject.to_s).to eq(", , ")
      end
    end

    context "when the item has a name, sell_in, and quality" do
      subject { Item.new("ItemName", 10, 50) }

      it "returns the correct string" do
        expect(subject.to_s).to eq("ItemName, 10, 50")
      end
    end
  end
end
