# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/product'

class ProductTest < Minitest::Test
  def test_non_imported_other_product
    product = Product.new(name: 'test', quantity: 1, price: 10.0, imported: false, category: Product::OTHER)

    assert_equal 11.0, product.total_price
    assert_equal 1.0, product.total_tax
    assert_equal 0.0, product.import_duty
    assert_equal 1.0, product.sales_tax
  end

  def test_non_imported_book_product
    product = Product.new(name: 'test', quantity: 2, price: 12.49, imported: false, category: Product::BOOK)

    assert_equal 24.98, product.total_price
    assert_equal 0.0, product.total_tax
    assert_equal 0.0, product.import_duty
    assert_equal 0.0, product.sales_tax
  end

  def test_imported_food_product
    product = Product.new(name: 'test', quantity: 3, price: 11.25, imported: true, category: Product::FOOD)

    assert_equal 35.55, product.total_price
    assert_equal 1.8, product.total_tax
    assert_equal 1.8, product.import_duty
    assert_equal 0, product.sales_tax
  end

  def test_imported_other_product
    product = Product.new(name: 'test', quantity: 2, price: 11.25, imported: true, category: Product::OTHER)

    assert_equal 26.0, product.total_price
    assert_equal 3.5, product.total_tax
    assert_equal 1.2, product.import_duty
    assert_equal 2.3, product.sales_tax
  end

  def test_imported_medical_product
    product = Product.new(name: 'test', quantity: 1, price: 9.75, imported: true, category: Product::MEDICAL)

    assert_equal 10.25, product.total_price
    assert_equal 0.5, product.total_tax
    assert_equal 0.5, product.import_duty
    assert_equal 0.0, product.sales_tax
  end
end
