# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/product_parser'
require_relative '../../lib/product'

class ProductParserTest < Minitest::Test
  def test_valid_input
    input = <<~TEXT
      2 book at 12.49
      1 music CD at 14.99
      1 chocolate bar at 0.85
      1 packet of headache pills at 9.75
      3 imported boxes of chocolates at 11.25
    TEXT

    parser = ProductParser.new
    products = parser.parse(input)

    assert_equal 5, products.size

    assert_equal products[0],
                 Product.new(quantity: 2, name: 'book', price: 12.49, imported: false, category: Product::BOOK)
    assert_equal products[1],
                 Product.new(quantity: 1, name: 'music CD', price: 14.99, imported: false, category: Product::OTHER)
    assert_equal products[2],
                 Product.new(quantity: 1, name: 'chocolate bar', price: 0.85, imported: false, category: Product::FOOD)
    assert_equal products[3],
                 Product.new(quantity: 1, name: 'packet of headache pills', price: 9.75, imported: false,
                             category: Product::MEDICAL)
    assert_equal products[4],
                 Product.new(quantity: 3, name: 'imported boxes of chocolates', price: 11.25, imported: true,
                             category: Product::FOOD)

    assert !parser.any_failures?
  end

  def test_invalid_input
    input = <<~TEXT
      3 unknown production at unknown price
      X imported invalid products at 3.15
      1 unknown packet of headache pills at 9.75
    TEXT

    parser = ProductParser.new
    products = parser.parse(input)

    assert_equal 1, products.size
    assert_equal products[0], Product.new(
      quantity: 1, name: 'unknown packet of headache pills',
      price: 9.75, imported: false, category: Product::MEDICAL
    )

    assert parser.any_failures?

    assert_equal 2, parser.invalid_rows.size
    assert_equal 'Invalid row format: 3 unknown production at unknown price', parser.invalid_rows[0][:error]
    assert_equal 'Invalid row format: X imported invalid products at 3.15', parser.invalid_rows[1][:error]
  end
end
