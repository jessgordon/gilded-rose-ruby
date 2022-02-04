require 'gilded_rose'

describe GildedRose do
  let(:vest) { Item.new('+5 Dexterity Vest', 10, 20) }
  let(:potion) { Item.new('Elixir of the Mongoose', 5, 7) }
  let(:aged_brie) { Item.new('Aged Brie', 2, 0) }
  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 50) }
  let(:backstage_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20) }
  let(:conjured) { Item.new('Conjured Mana Cake', 3, 20) }
  let(:items) { [vest, potion, aged_brie, sulfuras, backstage_pass, conjured] }
  let(:gilded_rose) { GildedRose.new(items) }

  it 'updates all items sell_in and quality each time daily_update is called' do
    #  DAY ONE
    gilded_rose.daily_update

    expect(vest.to_s).to eq('+5 Dexterity Vest, 9, 19')
    expect(potion.to_s).to eq('Elixir of the Mongoose, 4, 6')
    expect(aged_brie.to_s).to eq('Aged Brie, 1, 1')
    expect(sulfuras.to_s).to eq('Sulfuras, Hand of Ragnaros, 0, 50')
    expect(backstage_pass.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 14, 21')
    expect(conjured.to_s).to eq('Conjured Mana Cake, 2, 18')

    #  DAY TWO
    gilded_rose.daily_update

    expect(vest.to_s).to eq('+5 Dexterity Vest, 8, 18')
    expect(potion.to_s).to eq('Elixir of the Mongoose, 3, 5')
    expect(aged_brie.to_s).to eq('Aged Brie, 0, 2')
    expect(sulfuras.to_s).to eq('Sulfuras, Hand of Ragnaros, 0, 50')
    expect(backstage_pass.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 13, 22')
    expect(conjured.to_s).to eq('Conjured Mana Cake, 1, 16')

    #  DAY THREE
    gilded_rose.daily_update

    expect(vest.to_s).to eq('+5 Dexterity Vest, 7, 17')
    expect(potion.to_s).to eq('Elixir of the Mongoose, 2, 4')
    expect(aged_brie.to_s).to eq('Aged Brie, -1, 3')
    expect(sulfuras.to_s).to eq('Sulfuras, Hand of Ragnaros, 0, 50')
    expect(backstage_pass.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 12, 23')
    expect(conjured.to_s).to eq('Conjured Mana Cake, 0, 14')    

    #  DAY FOUR
    gilded_rose.daily_update

    expect(vest.to_s).to eq('+5 Dexterity Vest, 6, 16')
    expect(potion.to_s).to eq('Elixir of the Mongoose, 1, 3')
    expect(aged_brie.to_s).to eq('Aged Brie, -2, 4')
    expect(sulfuras.to_s).to eq('Sulfuras, Hand of Ragnaros, 0, 50')
    expect(backstage_pass.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 11, 24')
    expect(conjured.to_s).to eq('Conjured Mana Cake, -1, 10')  

    #  DAY FIVE
    gilded_rose.daily_update

    expect(vest.to_s).to eq('+5 Dexterity Vest, 5, 15')
    expect(potion.to_s).to eq('Elixir of the Mongoose, 0, 2')
    expect(aged_brie.to_s).to eq('Aged Brie, -3, 5')
    expect(sulfuras.to_s).to eq('Sulfuras, Hand of Ragnaros, 0, 50')
    expect(backstage_pass.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 10, 25')
    expect(conjured.to_s).to eq('Conjured Mana Cake, -2, 6') 
  end
end