# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/receipt_printer'
require_relative '../../lib/product'

class ReceiptPrinterTest < Minitest::Test
  def test_build_input1
    goods = [
      Product.new(name: 'book', quantity: 2, price: 12.49, imported: false, category: Product::BOOK),
      Product.new(name: 'music CD', quantity: 1, price: 14.99, imported: false, category: Product::OTHER),
      Product.new(name: 'chocolate bar', quantity: 1, price: 0.85, imported: false, category: Product::FOOD)
    ]

    receipt = ReceiptPrinter.new(goods).build

    assert_equal '2 book: 24.98', receipt[0]
    assert_equal '1 music CD: 16.49', receipt[1]
    assert_equal '1 chocolate bar: 0.85', receipt[2]
    assert_equal 'Sales Taxes: 1.50', receipt[3]
    assert_equal 'Total: 42.32', receipt[4]
  end

  def test_build_input2
    goods = [
      Product.new(name: 'imported box of chocolates', quantity: 1, price: 10.00, imported: true,
                  category: Product::FOOD),
      Product.new(name: 'imported bottle of perfume', quantity: 1, price: 47.50, imported: true,
                  category: Product::OTHER)
    ]

    receipt = ReceiptPrinter.new(goods).build

    assert_equal '1 imported box of chocolates: 10.50', receipt[0]
    assert_equal '1 imported bottle of perfume: 54.65', receipt[1]
    assert_equal 'Sales Taxes: 7.65', receipt[2]
    assert_equal 'Total: 65.15', receipt[3]
  end

  def test_build_input3
    goods = [
      Product.new(name: 'imported bottle of perfume', quantity: 1, price: 27.99, imported: true,
                  category: Product::OTHER),
      Product.new(name: 'bottle of perfume', quantity: 1, price: 18.99, imported: false, category: Product::OTHER),
      Product.new(name: 'packet of headache pills', quantity: 1, price: 9.75, imported: false,
                  category: Product::MEDICAL),
      Product.new(name: 'imported box of chocolates', quantity: 3, price: 11.25, imported: true,
                  category: Product::FOOD)
    ]

    receipt = ReceiptPrinter.new(goods).build

    assert_equal '1 imported bottle of perfume: 32.19', receipt[0]
    assert_equal '1 bottle of perfume: 20.89', receipt[1]
    assert_equal '1 packet of headache pills: 9.75', receipt[2]
    assert_equal '3 imported box of chocolates: 35.55', receipt[3]
    assert_equal 'Sales Taxes: 7.90', receipt[4]
    assert_equal 'Total: 98.38', receipt[5]
  end
end
