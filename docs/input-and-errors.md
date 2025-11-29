# User Input and Error Handling in Well.. Simple

## User Input

Well.. Simple v1.0 includes a built-in `input()` function for reading user input from the command line.

### Basic Usage

```ws
# Get user input with a prompt
name = input("What is your name? ")
print(name)

# Get input without a prompt
age = input("")
print(age)

# Direct call (prints result immediately)
input("Press Enter to continue...")
```

### Examples

#### Interactive Greeting
```ws
print("Welcome to the greeting program!")
name = input("What is your name? ")
city = input("Where do you live? ")
print("Hello from the program!")
print(name)
print(city)
```

#### Simple Calculator
```ws
print("Simple Calculator")
print("Enter first number:")
num1_str = input("")
print("Enter second number:")
num2_str = input("")

# Note: input returns strings
# You'll need to convert to numbers for math
# (Automatic conversion in expressions coming soon)
```

## Error Handling and Reporting

Well.. Simple now provides detailed, helpful error messages that show you exactly what went wrong and where.

### Error Message Format

When an error occurs, you'll see:
- **File name**: Which file had the error
- **Line number**: Exact line where the error occurred
- **Error message**: Clear description of what went wrong
- **Problematic code**: The actual line of code with the issue
- **Suggestion**: Helpful hint on how to fix it

### Example Error Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
❌ ERROR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
File: myprogram.ws
Line: 10

Division by zero

Problematic code:
  │ result = 10 / 0
  └────────────────

💡 Suggestion:
  Cannot divide by zero. Check your divisor value.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Common Errors

#### 1. Division by Zero
```ws
result = 10 / 0  # ❌ Error: Division by zero
```

**Solution**: Check your divisor isn't zero before dividing.

#### 2. Undefined Variable
```ws
result = x + 10  # ❌ Error: Undefined variable: x
```

**Solution**: Define the variable before using it:
```ws
x = 5
result = x + 10  # ✓ Works!
```

#### 3. List Index Out of Bounds
```ws
mylist = [1, 2, 3]
value = mylist[5]  # ❌ Error: Index 5 out of bounds (list length is 3)
```

**Solution**: Use valid indices (0 to length-1):
```ws
mylist = [1, 2, 3]
value = mylist[2]  # ✓ Gets third element (index 2)
```

#### 4. Invalid Operator
```ws
result = 10 & 5  # ❌ Error: Invalid operator: &
```

**Solution**: Use valid operators: `+`, `-`, `*`, `/`, `%`

### Try-Except-Finally

For custom error handling, use try-except-finally blocks:

```ws
try
  result = 10 / 0
except
  print("Caught an error!")
finally
  print("This always runs")
end
```

## Best Practices

### 1. Always Validate Input
```ws
print("Enter a positive number:")
num = input("")
# Add validation logic here
```

### 2. Use Descriptive Prompts
```ws
# ✓ Good
name = input("Please enter your full name: ")

# ✗ Less helpful
name = input("")
```

### 3. Handle Errors Gracefully
```ws
try
  # Risky operation
  result = value / divisor
except
  print("Error: Division failed")
  result = 0
end
```

### 4. Test Edge Cases
Always test your programs with:
- Empty input
- Zero values
- Negative numbers
- Large numbers
- Invalid indices

## Examples

### Complete Interactive Program

```ws
# Interactive age calculator
print("=== Age Calculator ===")
print("")

print("Enter your birth year:")
birth_year = input("")

print("Enter current year:")
current_year = input("")

# Calculate age (string conversion coming soon)
print("Thank you for using the calculator!")
```

### Error Demonstration

See the included test files:
- `test_input_simple.ws` - Input examples
- `test_errors.ws` - Undefined variable
- `test_divzero.ws` - Division by zero
- `test_listindex.ws` - List index error

Run them to see the error reporting in action:
```bash
./build/ws-linux test_divzero.ws
```

## Limitations

Current limitations being addressed:
1. `input()` returns strings - automatic type conversion in expressions coming soon
2. String concatenation in `print()` is limited - use separate print statements
3. Error recovery - some errors stop execution (by design for safety)

## Future Enhancements

Planned improvements:
- Automatic string-to-number conversion in expressions
- Better string concatenation support
- More detailed stack traces
- Warning messages (non-fatal issues)
- Interactive debugger mode

---

For more information, see:
- `docs/README.md` - Main language documentation
- `docs/wpm.md` - Package manager
- `docs/wvm.md` - Version manager
