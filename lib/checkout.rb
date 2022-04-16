# frozen_string_literal: true

require_relative 'basket'

# Checkout of basket items.
# Sample rule: { name: 'item_discount', min_items: 3, discount: 0.50, item_code: 'PAR' }
class Checkout
  def initialize(rules, items)
    @rules = rules
    @items = items
  end

  def amount_due
    ba = Basket.new(@rules)
    @items.each do |item|
      ba.add(item)
    end

    price = ba.total.round(2)

    puts "Price is £#{price} for items #{ba.items.map { |item| item['product_name'] }.join(', ')}."
    price
  end
end
