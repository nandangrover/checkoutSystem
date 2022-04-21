# frozen_string_literal: true

# Item Discount Rule: Discounts on items if there are minimum number bought together
class PercentOffRule
    def initialize(item_code, item_count, discount_percent, items)
      @item_code = item_code
      @item_count = item_count
      @discount_percent = discount_percent
      @items = items
    end
  
    def run
      count = 0
      @items.select { |item| item['product_code'] == @item_code }.each do |item|
        unless count  == @item_count
          item['price'] = (@discount_percent/100.0) * item['price']
          count += 1
        end
      end
    end
  
    private
  
    def quantity(item_code, items)
      items.select { |item| item['product_code'] == item_code }.count
    end
  end
  