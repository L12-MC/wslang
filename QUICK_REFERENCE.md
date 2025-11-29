# Well.. Simple - Quick Reference

## User Input

```ws
# Get input with prompt
name = input("Enter name: ")

# Get input without prompt  
value = input("")

# Direct call (press Enter to continue)
input("Press Enter...")
```

## Error Handling

```ws
# Try-catch-finally
try
  result = risky_operation()
except
  print("Error occurred!")
finally
  print("Always runs")
end
```

## Common Error Examples

### ❌ Division by Zero
```ws
result = 10 / 0  # Error with helpful message
```

### ❌ Undefined Variable
```ws
result = x + 10  # Must define x first
```

### ❌ List Index Out of Bounds
```ws
mylist = [1, 2, 3]
value = mylist[10]  # Index too large
```

### ✅ Correct Usage
```ws
x = 5
result = x + 10  # ✓ Works!

mylist = [1, 2, 3]
value = mylist[0]  # ✓ Valid index
```

## Error Message Format

When you see an error, it shows:
- 📁 **File name** - which file has the problem
- 📍 **Line number** - exact location
- ❌ **Error message** - what went wrong
- 📝 **Code snippet** - the problematic line
- 💡 **Suggestion** - how to fix it

## Running Programs

```bash
# Run a script
./build/ws-linux myprogram.ws

# Pipe input for testing
echo "Alice" | ./build/ws-linux myprogram.ws

# Multiple inputs
echo -e "Alice\n25\nUSA" | ./build/ws-linux myprogram.ws
```

## Getting Help

- Full docs: `docs/input-and-errors.md`
- Examples: `examples/safe_calculator.ws`
- Tests: `test_input_simple.ws`, `test_divzero.ws`

---
**Well.. Simple v1.0** | For full documentation see `docs/README.md`
