class GildedRose

  def initialize(items)
    @items = items
  end

  #  make a seperate method for update sell_in

  def update_quality
    @items.each do |item|
      unless item.name == "Sulfuras, Hand of Ragnaros"
        if item.name == "Aged Brie"
          update_aged_brie_quality(item)
        else
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              item.quality = item.quality - 1
            end
          else
            if item.quality < 50
              item.quality = item.quality + 1
              if item.name == "Backstage passes to a TAFKAL80ETC concert"
                if item.sell_in < 11
                  if item.quality < 50
                    item.quality = item.quality + 1
                  end
                end
                if item.sell_in < 6
                  if item.quality < 50
                    item.quality = item.quality + 1
                  end
                end
              end
            end
          end
          item.sell_in = item.sell_in - 1
          if item.sell_in < 0
            if item.name != "Backstage passes to a TAFKAL80ETC concert"
              if item.quality > 0
                item.quality = item.quality - 1
              end
            else
              item.quality = item.quality - item.quality
            end
          end
        end
      end
    end
  end

  private

  def update_aged_brie_quality(aged_brie)
    if aged_brie.quality < 50
      aged_brie.quality += 1
    end
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