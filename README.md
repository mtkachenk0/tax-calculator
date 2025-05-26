# Dependencies:
- ruby3.1

# Usage:
```bash
$ ruby tax_calculator_cli.rb <path_to_file>
```

# Examples:
```bash
ruby tax_calculator_cli.rb fixtures/input1.txt
ruby tax_calculator_cli.rb fixtures/input2.txt
ruby tax_calculator_cli.rb fixtures/input3.txt
```

# Tests:
```bash
# Run all tests
ruby -Ilib:test -e 'Dir["test/**/*_test.rb"].each { require_relative File.expand_path(_1) }'

# Run a specific test
$ ruby <path_to_test_file>
# Example:
ruby test/tax_calculator_test.rb
```
