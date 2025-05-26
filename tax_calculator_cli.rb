# frozen_string_literal: true

require_relative './lib/product_parser'
require_relative './lib/receipt_printer'

# Usage:
#   ruby tax_calculator_cli.rb fixtures/input1.txt
#
# This script reads a list of product descriptions from the specified input file,
# parses them into Product objects, handles any malformed rows, and prints
# a receipt with calculated taxes and totals.
class TaxCalculatorCLI
  def initialize(file_path)
    @file_path = file_path
    @parser = ProductParser.new
  end

  def run
    validate_input!

    products = @parser.parse(file_content)

    if @parser.any_failures?
      puts 'Invalid rows found:'
      @parser.invalid_rows.each do |error|
        puts "Row: '#{error[:row]}', Error: #{error[:error]}"
      end
      exit(1)
    end

    ReceiptPrinter.new(products).print
  end

  private

  def validate_input!
    raise 'File path is required' if @file_path.nil? || @file_path.empty?
    raise 'File is empty' if file_content.strip.empty?
  end

  def file_content
    @file_content ||= File.read(@file_path)
  rescue Errno::ENOENT
    raise "File not found: #{@file_path}"
    exit(1)
  end
end

TaxCalculatorCLI.new(ARGV[0]).run if __FILE__ == $PROGRAM_NAME
