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
  end
end
