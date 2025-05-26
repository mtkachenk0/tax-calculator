# frozen_string_literal: true

require_relative './product'

class ProductParser
  REGEXP = /(?<quantity>\d+)\s+(?<name>.+)\s+at\s+(?<price>\d+(?:\.\d{2})?)/

  attr_reader :invalid_rows

  def initialize
    @invalid_rows = []
  end

  def parse(input)
    input.split("\n").map do |row|
      data = parse_one(row)
      Product.new(**data) if data
    end.compact
  end

  def any_failures?
    @invalid_rows.any?
  end

  private

  def parse_one(row)
    match = row.match(REGEXP)
    raise "Invalid row format: #{row}" unless match

    name = match['name'].strip

    {
      name: match['name'],
      quantity: match['quantity'].to_i,
      price: match['price'].to_f,
      category: parse_category(name),
      imported: parse_imported(name)
    }
  rescue StandardError => e
    @invalid_rows << { row:, error: e.message }
    nil
  end

  def parse_category(name)
    case name.downcase
    when /book/ then Product::BOOK
    when /chocolate/ then Product::FOOD
    when /pills/ then Product::MEDICAL
    else Product::OTHER
    end
  end

  def parse_imported(name)
    name.downcase.include?('imported')
  end
end
