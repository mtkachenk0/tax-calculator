# 🧾 Sales Tax Calculator
A command-line Ruby app that reads a list of purchased items, calculates applicable sales taxes, and prints a formatted receipt.

## 📦 Features
- Applies basic sales tax (10%) to all goods except books, food, and medical products.
- Applies import duty (5%) to all imported goods, with no exemptions.
- Rounds tax amounts up to the nearest 0.05, per specification.
- Handles malformed input rows and reports them clearly.
- Fully test-covered with minitest.

## 📄 Input Format
Each input line should follow this format:
```
<quantity> <product name> at <price>

# Examples: 
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

### Dependencies:
- ruby2.6+
- No external dependencies

## Usage:
```bash
$ ruby tax_calculator_cli.rb <path_to_file>

# If any invalid lines are found, they will be printed with error messages, and the app will exit with status 1.

# Examples:
ruby tax_calculator_cli.rb fixtures/input1.txt
ruby tax_calculator_cli.rb fixtures/input2.txt
ruby tax_calculator_cli.rb fixtures/input3.txt
```

## Tests:
```bash
# Run all tests
ruby -Ilib:test -e 'Dir["test/**/*_test.rb"].each { require_relative File.expand_path(_1) }'

# Or individually
$ ruby <path_to_test_file>
# Example:
ruby test/tax_calculator_test.rb
```

