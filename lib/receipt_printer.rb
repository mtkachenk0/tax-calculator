# frozen_string_literal: true

require 'pry'

class ReceiptPrinter
  def initialize(goods)
    @goods = goods
  end

  def build
    rows = []
    @goods.each do |product|
      rows << product_row(product)
    end
    rows << "Sales Taxes: #{'%.2f' % total_tax}"
    rows << "Total: #{'%.2f' % total_price}"
    rows
  end

  def print
    build.each { |row| puts row }
  end

  private

  def total_price
    @goods.sum(&:total_price)
  end

  def total_tax
    @goods.sum(&:total_tax)
  end

  def product_row(product)
    "#{product.quantity} #{product.name}: #{'%.2f' % product.total_price}"
  end
end
