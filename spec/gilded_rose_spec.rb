require 'gilded_rose'

describe GildedRose do
  describe '#daily_update' do

    let(:vest) { Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20) }
    let(:potion) { Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7) }
    let(:aged_brie) { Item.new(name="Aged Brie", sell_in=2, quality=0) }
    let(:sulfuras) { Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=50) }
    let(:backstage_pass) { 
      Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20) }
    let(:gilded_rose) { GildedRose.new([vest, potion, aged_brie, sulfuras, backstage_pass]) }
    
    it 'lowers the sell_in value by one each day as default - vest example' do
      expect { gilded_rose.daily_update }.to change { vest.sell_in }.from(10).to(9)
    end
    
    it 'lowers the sell_in value by one each day as default - potion example' do
      expect { gilded_rose.daily_update }.to change { potion.sell_in }.from(5).to(4)
    end 
    
    it 'lowers the quality value by one each day as default - vest example' do
      expect { gilded_rose.daily_update }.to change { vest.quality }.from(20).to(19)
    end
    
    it 'lowers the quality value by one each day as default - potion example' do
      expect { gilded_rose.daily_update }.to change { potion.quality }.from(7).to(6)
    end 
    
    it 'degrades quality twice as fast once the sell by date has passed - vest example' do
      11.times { gilded_rose.daily_update }
      
      expect(vest.sell_in).to eq(-1)
      expect(vest.quality).to eq(8)
    end
    
    it 'degrades quality twice as fast once the sell by date has passed - potion example' do
      6.times { gilded_rose.daily_update }
      
      expect(potion.sell_in).to eq(-1)
      expect(potion.quality).to eq(0)
    end
    
    it 'ensures the quality of an item is never negative - vest example' do
      20.times { gilded_rose.daily_update }
      
      expect(vest.quality).to eq(0)
    end
    
    it 'ensures the quality of an item is never negative - potion example' do
      20.times { gilded_rose.daily_update }
      
      expect(potion.quality).to eq(0)
    end
    
    context 'Aged Brie' do
      it 'increases the quality value by one each day for Aged Brie' do
        expect { gilded_rose.daily_update }.to change { aged_brie.quality }.from(0).to(1)
      end
      
      it 'ensures the quality of an item is never more than 50' do
        60.times { gilded_rose.daily_update }
        
        expect(aged_brie.quality).to be(50)
      end
    end
    
    context 'Sulfuras' do
      it 'does not alter the sell_in value for Sulfuras, Hand of Ragnaros' do
        gilded_rose.daily_update
        
        expect(sulfuras.sell_in).to eq(0)
      end
      
      it 'does not alter the quality value for Sulfuras, Hand of Ragnaros' do
        gilded_rose.daily_update
        
        expect(sulfuras.quality).to eq(50)
      end
    end

    context 'Backstage passes' do
      it 'increases the quality value by one each day when sell_in is above ten' do
        5.times { gilded_rose.daily_update }

        expect(backstage_pass.sell_in).to eq(10)
        expect(backstage_pass.quality).to eq(25)
      end

      it 'increases the quality value by two when sell_in is ten or less' do
        10.times { gilded_rose.daily_update }

        expect(backstage_pass.sell_in).to eq(5)
        expect(backstage_pass.quality).to eq(35)
      end

      it 'increases the quality value by three when sell_in is five or less' do
        15.times { gilded_rose.daily_update }

        expect(backstage_pass.sell_in).to eq(0)
        expect(backstage_pass.quality).to eq(50)
      end

      it 'drops the quality value to zero after the concert' do
        16.times { gilded_rose.daily_update }

        expect(backstage_pass.sell_in).to eq(-1)
        expect(backstage_pass.quality).to eq(0)
      end
    end
  end
end