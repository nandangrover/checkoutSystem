# frozen_string_literal: true

require_relative '../lib/checkout'

describe Checkout do
  describe '#amount_due without discounted rule' do
    it 'is expected to return the correct price of the item without discount' do
      checkout = Checkout.new([], %w[PAR PAR PAR])

      expect(checkout.amount_due).to eq(15.00)
    end

    it 'is expected to return the correct price of the item with discount' do
      rules = [{ name: 'item_discount', min_items: 3, discount: 0.50, item_code: 'PAR' },
               { name: 'item_discount', min_items: 4, discount: 0.50, item_code: 'BAS' }]
      checkout = Checkout.new(rules, %w[PAR PAR PAR])

      expect(checkout.amount_due).to eq(13.5)
    end

    it 'is returns correct discount with multiple items added to the rules' do
      rules = [{ name: 'item_discount', min_items: 3, discount: 0.50, item_code: 'PAR' },
               { name: 'item_discount', min_items: 4, discount: 0.50, item_code: 'BAS' }]
      checkout = Checkout.new(rules, %w[PAR PAR BAS BAS PAR BAS BAS])

      expect(checkout.amount_due).to eq(23.94)
    end

    it 'is returns correct discount with the percent off rule for 4 items and 2 count' do
      rules = [{ name: 'percent_off', item_count: 2, discount_percent: 50, item_code: 'ROS' }]
      checkout = Checkout.new(rules, %w[ROS ROS ROS ROS])

      expect(checkout.amount_due).to eq(6)
    end

    it 'is returns correct discount with the percent off rule for 4 items and 1 count' do
      rules = [{ name: 'percent_off', item_count: 1, discount_percent: 50, item_code: 'ROS' }]
      checkout = Checkout.new(rules, %w[ROS ROS ROS ROS])

      expect(checkout.amount_due).to eq(7)
    end
  end
end
