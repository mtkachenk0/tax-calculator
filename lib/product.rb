# frozen_string_literal: true

class Product
  CATEGORIES = %i[book food medical other].freeze.each do |category|
    const_set(category.upcase, category)
  end

  attr_reader :name, :quantity, :price, :category, :imported

  def initialize(name:, quantity:, price:, category:, imported:)
    @name = name
    @quantity = quantity
    @category = category
    @price = price
    @imported = imported || false
  end

  def total_price
    @quantity * @price + sales_tax + import_duty
  end

  def total_tax
    import_duty + sales_tax
  end

  # Although `import_duty` and `sales_tax` are not currently used outside the class,
  # they are part of the logical domain interface and useful for testing and debugging.
  # Keeping them public improves clarity and transparency of tax-related calculations.
  def import_duty
    @imported ? (round_tax(@price * 0.05) * @quantity).round(2) : 0 # < round(2) to avoid infinite precision issues
  end

  def sales_tax
    exempt? ? 0 : (round_tax(@price * 0.1) * @quantity).round(2)
  end

  def ==(other)
    return false unless other.is_a?(Product)

    @name == other.name &&
      @quantity == other.quantity &&
      @price == other.price &&
      @category == other.category &&
      @imported == other.imported
  end

  private

  def exempt?
    @category != OTHER
  end

  def round_tax(value)
    (value * 20).ceil / 20.0
  end
end
