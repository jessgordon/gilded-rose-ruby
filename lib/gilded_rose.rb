class GildedRose

  DEFAULT_MAX_QUALITY = 50
  DEFAULT_MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  #  make a seperate method for update sell_in

  def daily_update
    @items.each do |item|
      unless item.name == "Sulfuras, Hand of Ragnaros"
        update_sell_in(item)
        update_quality(item)
      end
    end
  end

  private

  def update_quality(item)
    if item.name == "Aged Brie"
      update_aged_brie_quality(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      update_backstage_passes_quality(item)
    else
      update_quality_default(item)
    end
  end

  def update_aged_brie_quality(aged_brie)
    aged_brie.quality += 1
    guard_quality_upper_limit(aged_brie)
  end

  def update_backstage_passes_quality(backstage_pass)
    backstage_pass.quality += 1
    backstage_pass.quality += 1 if backstage_pass.sell_in < 10
    backstage_pass.quality += 1 if backstage_pass.sell_in < 5
    backstage_pass.quality = 0 if backstage_pass.sell_in < 0
    guard_quality_upper_limit(backstage_pass)  
  end

  def update_quality_default(item)
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
    guard_quality_lower_limit(item)
  end

  def guard_quality_upper_limit(item)
    item.quality = 50 if item.quality > DEFAULT_MAX_QUALITY
  end

  def guard_quality_lower_limit(item)
    item.quality = 0 if item.quality < DEFAULT_MIN_QUALITY
  end

  def update_sell_in(item)
    item.sell_in -= 1
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