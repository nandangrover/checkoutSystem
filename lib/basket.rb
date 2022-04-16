# frozen_string_literal: true

require 'json'
require_relative 'rules/adapter'

# Basket for storing and checking out all items
class Basket
  attr_reader :items, :items_hash, :rules

  def initialize(rules)
    @rules = rules
    file = File.read('lib/items.json')
    @items_hash = JSON.parse(file)
    @items = []
  end

  def add(item_code)
    @items << items_hash[item_code].clone
  end

  def total
    RuleAdapter.new(rules, items).apply
    @items.inject(0) { |sum, item| sum + item['price'] }
  end
end
