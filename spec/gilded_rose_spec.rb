# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  describe '#daily_update' do
    context 'when the item is updated using the default functions' do
      let(:vest) { Item.new('+5 Dexterity Vest', 10, 20) }
      let(:gilded_rose) { GildedRose.new([vest]) }

      it 'lowers the sell_in value by one each day as default' do
        expect { gilded_rose.daily_update }.to change { vest.sell_in }.from(10).to(9)
      end

      it 'lowers the quality value by one each day as default' do
        expect { gilded_rose.daily_update }.to change { vest.quality }.from(20).to(19)
      end

      it 'degrades quality twice as fast once the sell by date has passed' do
        11.times { gilded_rose.daily_update }

        expect(vest.sell_in).to eq(-1)
        expect(vest.quality).to eq(8)
      end

      it 'ensures the quality of an item is never negative' do
        20.times { gilded_rose.daily_update }

        expect(vest.quality).to eq(0)
      end
    end

    context 'when the item name is Aged Brie' do
      let(:aged_brie) { Item.new('Aged Brie', 2, 0) }
      let(:gilded_rose) { GildedRose.new([aged_brie]) }

      it 'lowers the sell_in value by one each day' do
        expect { gilded_rose.daily_update }.to change { aged_brie.sell_in }.from(2).to(1)
      end

      it 'increases the quality value by one each day for Aged Brie' do
        expect { gilded_rose.daily_update }.to change { aged_brie.quality }.from(0).to(1)
      end

      it 'ensures the quality of an item is never more than 50' do
        60.times { gilded_rose.daily_update }

        expect(aged_brie.quality).to be(50)
      end
    end

    context 'when the item name is Sulfuras' do
      let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 50) }
      let(:gilded_rose) { GildedRose.new([sulfuras]) }

      it 'does not alter the sell_in value for Sulfuras, Hand of Ragnaros' do
        gilded_rose.daily_update

        expect(sulfuras.sell_in).to eq(0)
      end

      it 'does not alter the quality value for Sulfuras, Hand of Ragnaros' do
        gilded_rose.daily_update

        expect(sulfuras.quality).to eq(50)
      end
    end

    context 'when the item name is Backstage passes' do
      let(:backstage_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20) }
      let(:gilded_rose) { GildedRose.new([backstage_pass]) }

      it 'lowers the sell_in value by one each day' do
        expect { gilded_rose.daily_update }.to change { backstage_pass.sell_in }.from(15).to(14)
      end
      
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

    context 'when the item is Conjured' do
      let(:conjured) { Item.new("Conjured Mana Cake", 3, 20) }
      let(:gilded_rose) { GildedRose.new([conjured]) }

      it 'lowers the sell_in value by one each day' do
        expect { gilded_rose.daily_update }.to change { conjured.sell_in }.from(3).to(2)
      end

      it 'lowers the quality value twice as fast as the default - while within sell by date' do
        expect { gilded_rose.daily_update }.to change { conjured.quality }.from(20).to(18)
      end

      it 'lowers the quality value twice as fast as the default - when passed the sell by date' do
        3.times { gilded_rose.daily_update }
        expect { gilded_rose.daily_update }.to change { conjured.quality }.from(14).to(10)
      end   
    end
  end
end
