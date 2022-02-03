class GildedRose

  DEFAULT_MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  #  make a seperate method for update sell_in

  def update_quality
    @items.each do |item|
      unless item.name == "Sulfuras, Hand of Ragnaros"
        if item.name == "Aged Brie"
          update_aged_brie_quality(item)
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          update_backstage_passes_quality(item)
        else
          if item.quality > 0
            item.quality = item.quality - 1
          end
          item.sell_in = item.sell_in - 1
          if item.sell_in < 0
            if item.quality > 0
              item.quality = item.quality - 1
            end
          end
        end
      end
    end
  end

  private

  def update_aged_brie_quality(aged_brie)
    aged_brie.quality += 1
    guard_quality_upper_limit(aged_brie)
    aged_brie.sell_in = aged_brie.sell_in - 1
  end

  def update_backstage_passes_quality(backstage_pass)
    backstage_pass.sell_in = backstage_pass.sell_in - 1
    backstage_pass.quality += 1
    backstage_pass.quality += 1 if backstage_pass.sell_in < 10
    backstage_pass.quality += 1 if backstage_pass.sell_in < 5
    backstage_pass.quality = 0 if backstage_pass.sell_in < 0
    guard_quality_upper_limit(backstage_pass)  
  end

  def guard_quality_upper_limit(item)
    item.quality = 50 if item.quality > DEFAULT_MAX_QUALITY
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end