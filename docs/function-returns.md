# Function Returns - Well.. Simple v1.0.2

## Overview

Functions in Well.. Simple can now return values using the `return` statement. These values can be used in assignments, expressions, and even nested function calls.

## Syntax

```ws
def function_name(param1, param2)
  # Function body
  return value
end
```

## Features

### 1. Basic Return
```ws
def add(a, b)
  result = a + b
  return result
end

sum = add(5, 3)
print(sum)  # Outputs: 8.0
```

### 2. Return Expressions
```ws
def multiply(x, y)
  return x * y
end

product = multiply(4, 7)
print(product)  # Outputs: 28.0
```

### 3. Early Return
```ws
def max(a, b)
  if a > b
    return a
  end
  return b
end

maximum = max(10, 15)
print(maximum)  # Outputs: 15.0
```

### 4. Function Calls in Expressions
```ws
def square(x)
  return x * x
end

# Use function returns in calculations
result = square(3) + square(4)
print(result)  # Outputs: 25.0

# Nested function calls
total = add(10, 20) + multiply(2, 3)
print(total)  # Outputs: 36.0
```

### 5. Print Function Results
```ws
def calculate(x)
  return x * 2 + 10
end

print(calculate(5))  # Outputs: 20.0
```

## Return Types

Functions can return:
- **Numbers**: `return 42` or `return x + y`
- **Strings**: `return "hello"`
- **Booleans**: `return true` or `return false`
- **Lists**: `return [1, 2, 3]`
- **Variables**: `return result`
- **Null**: `return` (without value)

## Important Notes

### Functions Without Return
If a function doesn't have a `return` statement, it returns `null`:

```ws
def print_message(msg)
  print(msg)
  # No return statement
end

result = print_message("Hello")  # result will be null
```

### Return Stops Execution
Once a `return` statement is executed, the function immediately exits:

```ws
def example()
  print("This prints")
  return 5
  print("This never prints")
end
```

### Return in Loops
You can return from within loops:

```ws
def find_first_positive(numbers)
  i = 0
  while i < len(numbers)
    if numbers[i] > 0
      return numbers[i]
    end
    i = i + 1
  end
  return -1  # Not found
end
```

## Examples

### Factorial Function
```ws
def factorial(n)
  if n <= 1
    return 1
  end
  result = 1
  i = 2
  while i <= n
    result = result * i
    i = i + 1
  end
  return result
end

print(factorial(5))  # Outputs: 120.0
```

### Distance Calculator
```ws
def distance(x1, y1, x2, y2)
  dx = x2 - x1
  dy = y2 - y1
  return dx * dx + dy * dy  # Squared distance
end

dist = distance(0, 0, 3, 4)
print(dist)  # Outputs: 25.0
```

### Conditional Return
```ws
def grade(score)
  if score >= 90
    return "A"
  end
  if score >= 80
    return "B"
  end
  if score >= 70
    return "C"
  end
  return "F"
end

# Note: Currently returns numbers, string returns coming soon
```

## REPL Usage

Function returns work in interactive mode too:

```
>> def double(x)
...   return x * 2
... end
>> result = double(21)
>> print(result)
42.0
>> print(double(5) + double(10))
30.0
```

## Limitations

Current limitations:
- Return values are primarily numeric (string handling limited)
- No explicit return type declarations
- Recursion is possible but stack depth is limited

## Comparison with Built-in Functions

Some built-in functions like `square()` from mathlib print their results rather than returning them. When using library functions, check their documentation:

```ws
import libs/mathlib/mathlib

# mathlib's square() prints, doesn't return
square(5)  # Prints 25.0

# Your function can return
def my_square(x)
  return x * x
end

result = my_square(5)  # Stores 25.0 in result
```

## Best Practices

1. **Always return a value** if the function is meant to be used in expressions
2. **Use early returns** to simplify conditional logic
3. **Document what your function returns** in comments
4. **Test edge cases** like zero, negative numbers, empty lists, etc.

## Migration from v1.0.1

If you have functions that modified variables or printed values, they can now return those values instead:

### Before (v1.0.1):
```ws
def calculate(x)
  result = x * 2
  # Result stored in global variable
end

calculate(5)
print(result)  # Relied on global variable
```

### After (v1.0.2):
```ws
def calculate(x)
  return x * 2
end

result = calculate(5)
print(result)  # Clean and explicit
```

---

**Well.. Simple v1.0.2** - Function returns make your code more modular and easier to test!
