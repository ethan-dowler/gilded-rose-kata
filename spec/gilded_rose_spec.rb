require_relative "../src/gilded_rose"

describe GildedRose do
  let(:item_name) { "Generic Item" }
  let(:sell_in) { 10 }
  let(:quality) { 10 }
  let(:item) { Item.new(item_name, sell_in, quality) }
  let(:items) { [item] }
  
  # TODO: implement conjured feature
  let(:conjured) { false }

  subject { described_class.new(items) }

  describe "#update_quality" do
    context "when given a generic item" do
      it "reduces the sell_in by 1" do
        subject.update_quality

        expect(item.sell_in).to eq(9)
      end

      it "reduces the quality by 1" do
        subject.update_quality

        expect(item.quality).to eq(9)
      end

      context "when the item is conjured" do
        let(:conjured) { true }
  
        it "reduces the quality by 2" do
          subject.update_quality
  
          expect(item.quality).to eq(8)
        end
      end
    end

    context "when the sell by date has passed" do
      let(:sell_in) { 0 }

      it "reduces the quality by 2" do
        subject.update_quality

        expect(item.quality).to eq(8)
      end

      context "when the item is conjured" do
        let(:conjured) { true }
  
        it "reduces the quality by 4" do
          subject.update_quality
  
          expect(item.quality).to eq(6)
        end
      end
    end

    context "when given an item with 0 quality" do
      let(:quality) { 0 }

      it "keeps the quality the same" do
        subject.update_quality

        expect(item.quality).to eq(0)
      end
    end

    context "when the item is 'Aged Brie'" do
      let(:item_name) { "Aged Brie" }

      it "increases the quality by 1" do
        subject.update_quality

        expect(item.quality).to eq(11)
      end

      context "when the item has a quality of 50" do
        let(:quality) { 50 }

        it "keeps the quality the same" do
          subject.update_quality
  
          expect(item.quality).to eq(50)
        end
      end
    end

    context "when the item is 'Sulfuras'" do
      let(:item_name) { "Sulfuras, Hand of Ragnaros" }

      it "keeps the sell by date the same" do
        subject.update_quality
  
        expect(item.sell_in).to eq(10)
      end

      it "keeps the quality the same" do
        subject.update_quality
  
        expect(item.quality).to eq(10)
      end

      context "when the quality is over 50" do
        let(:quality) { 80 }

        it "keeps the quality the same" do
          subject.update_quality
    
          expect(item.quality).to eq(80)
        end
      end
    end

    context "when the item is 'Backstage passes'" do
      let(:item_name) { "Backstage passes to a TAFKAL80ETC concert" }
  
      context "when there are 11 days until the concert" do
        let(:sell_in) { 11 }
  
        it "increases the quality by 1" do
          subject.update_quality
    
          expect(item.quality).to eq(11)
        end
      end

      context "when there are 10 days until the concert" do
        let(:sell_in) { 10 }
  
        it "increases the quality by 2" do
          subject.update_quality
    
          expect(item.quality).to eq(12)
        end
      end
  
      context "when there are 6 days until the concert" do
        let(:sell_in) { 6 }
  
        it "increases the quality by 2" do
          subject.update_quality
    
          expect(item.quality).to eq(12)
        end
      end
  
      context "when there are 5 days until the concert" do
        let(:sell_in) { 5 }
  
        it "increases the quality by 3" do
          subject.update_quality
    
          expect(item.quality).to eq(13)
        end
      end
  
      context "when there is 1 day until the concert" do
        let(:sell_in) { 1 }
  
        it "increases the quality by 3" do
          subject.update_quality
    
          expect(item.quality).to eq(13)
        end
      end
  
      context "when the concert has passed" do
        let(:sell_in) { 0 }
  
        it "reduces the quality to 0" do
          subject.update_quality
    
          expect(item.quality).to eq(0)
        end
      end
  
      context "when the item has a quality of 50" do
        let(:quality) { 50 }
  
        it "keeps the quality the same" do
          subject.update_quality
  
          expect(item.quality).to eq(50)
        end
      end
    end
  end
end
