describe GildedRose do
  describe '#daily_update' do
    let(:vest) { Item.new('+5 Dexterity Vest', 10, 20) }
    let(:potion) { Item.new('Elixir of the Mongoose', 5, 7) }
    let(:aged_brie) { Item.new('Aged Brie', 2, 0) }
    let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 50) }
    let(:backstage_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20) }
    let(:gilded_rose) { GildedRose.new([vest, potion, aged_brie, sulfuras, backstage_pass]) }
  end 
end