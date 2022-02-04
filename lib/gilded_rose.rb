class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  ONE_QUALITY_UNIT = 1
  ONE_SELL_IN_UNIT = 1

  TEN_DAYS = 10
  FIVE_DAYS = 5

  def initialize(items)
    @items = items
  end

  def daily_update
    @items.each do |item|
      unless item.name == 'Sulfuras, Hand of Ragnaros'
        update_sell_in(item)
        update_quality(item)
      end
    end
  end

  private

  def update_quality(item)
    case item.name
    when 'Aged Brie'
      update_aged_brie_quality(item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      update_backstage_passes_quality(item)
    when 'Conjured Mana Cake'
      update_conjured_quality(item)
    else
      update_quality_default(item)
    end
  end

  def update_aged_brie_quality(aged_brie)
    aged_brie.quality += ONE_QUALITY_UNIT
    guard_quality_upper_limit(aged_brie)
  end

  def update_backstage_passes_quality(backstage_pass)
    backstage_pass.quality += ONE_QUALITY_UNIT
    backstage_pass.quality += ONE_QUALITY_UNIT if backstage_pass.sell_in < TEN_DAYS
    backstage_pass.quality += ONE_QUALITY_UNIT if backstage_pass.sell_in < FIVE_DAYS
    backstage_pass.quality = MIN_QUALITY if backstage_pass.sell_in.negative?
    guard_quality_upper_limit(backstage_pass)
  end

  def update_conjured_quality(item)
    update_quality_default(item)
    update_quality_default(item)
  end

  def update_quality_default(item)
    item.quality -= ONE_QUALITY_UNIT
    item.quality -= ONE_QUALITY_UNIT if item.sell_in.negative?
    guard_quality_lower_limit(item)
  end

  def guard_quality_upper_limit(item)
    item.quality = MAX_QUALITY if item.quality > MAX_QUALITY
  end

  def guard_quality_lower_limit(item)
    item.quality = MIN_QUALITY if item.quality < MIN_QUALITY
  end

  def update_sell_in(item)
    item.sell_in -= ONE_SELL_IN_UNIT
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
