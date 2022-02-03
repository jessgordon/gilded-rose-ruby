require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
# - At the end of each day our system lowers both values for every item

# - Once the sell by date has passed, Quality degrades twice as fast
# - The Quality of an item is never negative
# - The Quality of an item is never more than 50

# - “Aged Brie” actually increases in Quality the older it gets
# - “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
# - “Backstage passes”, like aged brie, increases in Quality as it’s `SellIn` value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
  let(:vest) { Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20) }
  let(:potion) { Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7) }
  let(:gilded_rose) { GildedRose.new([vest, potion]) }

    it 'lowers the sell_in value by one each day as default - vest example' do
      expect { gilded_rose.update_quality }.to change { vest.sell_in }.from(10).to(9)
    end

    it 'lowers the sell_in value by one each day as default - potion example' do
      expect { gilded_rose.update_quality }.to change { potion.sell_in }.from(5).to(4)
    end 
    
    it 'lowers the quality value by one each day as default - vest example' do
      expect { gilded_rose.update_quality }.to change { vest.quality }.from(20).to(19)
    end

    it 'lowers the quality value by one each day as default - potion example' do
      expect { gilded_rose.update_quality }.to change { potion.quality }.from(7).to(6)
    end 
  end
end