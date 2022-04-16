# frozen_string_literal: true

require_relative 'item_discount_rule'

# Adapter for calling all rules
class RuleAdapter
  def initialize(rules, items)
    @rules = rules
    @rules.map! do |rule|
      ItemDiscountRule.new(rule[:item_code], rule[:min_items], rule[:discount], items) if rule[:name] == 'item_discount'
    end
  end

  def apply
    @rules.each(&:run)
  end
end
