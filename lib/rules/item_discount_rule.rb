# frozen_string_literal: true

# Item Discount Rule: Discounts on items if there are minimum number bought together
class ItemDiscountRule
  def initialize(item_code, min_items, discount, items)
    @item_code = item_code
    @min_items = min_items
    @discount = discount
    @items = items
  end

  def run
    @items.select { |item| item['product_code'] == @item_code }.each do |item|
      item['price'] = item['price'] - @discount if quantity(item['product_code'], @items) >= @min_items
    end
  end

  private

  def quantity(item_code, items)
    items.select { |item| item['product_code'] == item_code }.count
  end
end
