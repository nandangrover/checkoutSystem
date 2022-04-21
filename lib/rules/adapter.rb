# frozen_string_literal: true

require_relative 'item_discount_rule'
require_relative 'percent_off_rule'

# Adapter for calling all rules
class RuleAdapter
  def initialize(rules, items)
    @rules = rules
    @rules.map! do |rule|
      case rule[:name]
      when "item_discount"
        ItemDiscountRule.new(rule[:item_code], rule[:min_items], rule[:discount], items)
      when "percent_off"
        PercentOffRule.new(rule[:item_code], rule[:item_count], rule[:discount_percent], items)
      else
        throw "No such rule found"
      end
    end
  end

  def apply
    @rules.each(&:run)
  end
end
