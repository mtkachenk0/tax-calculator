# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../tax_calculator_cli'

class TaxCalculatorCLITest < Minitest::Test
  def test_successful_receipt_output
    tax_calculator = TaxCalculatorCLI.new('fixtures/input1.txt')

    output = capture_stdout { tax_calculator.run }

    assert_includes output, '2 book: 24.98'
    assert_includes output, 'Sales Taxes: 1.50'
    assert_includes output, 'Total: 42.32'
  end

  def test_invalid_rows_abort_with_error
    tax_calculator  = TaxCalculatorCLI.new('fixtures/invalid_input.txt')

    output = capture_stdout do
      assert_raises(SystemExit) { tax_calculator.run }
    end

    assert_includes output, 'Invalid rows found:'
    assert_includes output, 'invalid line without price'
  end

  private

  def capture_stdout
    old_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end
end
