# REPL v0.3 - What's New

## Overview

Version 0.3 introduces major new features including full list support, string manipulation, file imports, and a comprehensive graphics engine.

## New Features

### 1. ✨ Lists

Full support for list data structures:

```repl
# Create lists
numbers = [1, 2, 3, 4, 5]
names = ["Alice", "Bob", "Charlie"]
mixed = [1, "hello", true, 3.14]

# Access elements
print(numbers[0])  # 1.0
print(names[2])    # Charlie

# Append elements
append(numbers, 6)
print(numbers)     # [1, 2, 3, 4, 5, 6]

# Get length
len = length(numbers)
print(len)         # 6.0
```

### 2. ✨ String Merging

Concatenate strings using the `+` operator:

```repl
first = "Hello"
second = "World"
greeting = first + " " + second
print(greeting)  # Hello World

# Build complex strings
name = "Alice"
age = 30
message = "My name is " + name + " and I am " + age + " years old"
```

### 3. ✨ String Splitting

Split strings into lists:

```repl
data = "apple,banana,cherry"
fruits = split(data, ",")
print(fruits)  # [apple, banana, cherry]
print(fruits[1])  # banana

# Split by spaces
sentence = "The quick brown fox"
words = split(sentence, " ")
print(words)  # [The, quick, brown, fox]
```

### 4. ✨ File Import and Execution

Load and execute .repl files:

```repl
# Import a library
import mathlib
square(5)  # Uses function from mathlib.repl

# Run a program
run examples/house

# Import from subdirectories
import lib/utilities
```

**Command line execution:**
```bash
dart main.dart myprogram.repl
```

### 5. ✨ Graphics Engine

Comprehensive canvas drawing system:

```repl
# Clear canvas
canvas.clear()

# Draw shapes
canvas.drawCircle(100, 100, 50, "red")
canvas.drawRectangle(200, 200, 100, 80, "blue")
canvas.drawTriangle(300, 300, 400, 300, 350, 200, "green")
canvas.drawLine(0, 0, 100, 100, "black")
canvas.drawPolygon([100, 100, 150, 150, 50, 150], "purple")

# Render to console
canvas.render()

# Export to SVG file
canvas.exportSVG("output.svg")
```

#### Available Shapes:
- **Circle**: `canvas.drawCircle(x, y, radius, color)`
- **Rectangle**: `canvas.drawRectangle(x, y, width, height, color)`
- **Triangle**: `canvas.drawTriangle(x1, y1, x2, y2, x3, y3, color)`
- **Line**: `canvas.drawLine(x1, y1, x2, y2, color)`
- **Polygon**: `canvas.drawPolygon([x1, y1, x2, y2, ...], color)`

## Enhanced Features

### Better Print Function
```repl
# Print lists
print(numbers)

# Print list elements
print(numbers[2])

# Print strings
print("Hello, World!")

# Print variables
print(myVariable)
```

### Function Support for Built-ins
```repl
# Length works with strings and lists
length("hello")  # 5.0
length([1, 2, 3, 4])  # 4.0

# Split returns a list
result = split("a,b,c", ",")
print(result)  # [a, b, c]
```

## Example Programs

### Simple Drawing
```repl
canvas.clear()
canvas.drawCircle(400, 300, 100, "blue")
canvas.drawRectangle(300, 250, 200, 100, "red")
canvas.render()
canvas.exportSVG("simple.svg")
```

### Using Libraries
```repl
import examples/shapes
canvas.clear()
drawHouse(300, 350, 100, "beige")
drawTree(100, 400, 80, "green")
canvas.render()
```

### Data Processing
```repl
# Parse CSV data
data = "Alice,30,Engineer"
fields = split(data, ",")
name = fields[0]
age = fields[1]
job = fields[2]
print("Name: " + name)
```

### List Operations
```repl
scores = [85, 92, 78, 90, 88]
print("Scores:")
print(scores)

# Calculate average
sum = 0
for i in range(0, length(scores))
  sum = sum + scores[i]
end
avg = sum / length(scores)
print("Average: " + avg)
```

## Breaking Changes

None - all v0.2 code should work in v0.3.

## Bug Fixes

- Fixed expression evaluation for complex expressions
- Improved string handling in variables
- Better error messages for invalid operations

## Performance

- File import is optimized for quick loading
- Canvas rendering handles thousands of shapes efficiently
- List operations are native Dart lists for maximum performance

## Known Limitations

- Canvas is text-based rendering (use SVG export for visuals)
- No real-time animation support
- For loops in files require explicit range values (can't use length() directly in range)
- No recursive file imports (will cause infinite loops)

## Future Roadmap

- Classes and objects (v0.4)
- More string functions (substring, replace, etc.)
- List sorting and searching
- Dictionary/map data structure
- Try/catch error handling
- More canvas features (text, gradients, transforms)

## Migration Guide

If you're upgrading from v0.2:

1. **Lists are now properly supported** - Use `[1, 2, 3]` syntax instead of workarounds
2. **String concatenation** - Use `+` operator: `str1 + str2`
3. **File organization** - Move reusable code to .repl files and import them
4. **Graphics** - Replace any custom drawing code with canvas API

## Getting Help

Type `help` in the REPL for quick reference:
```repl
>> help
```

See documentation:
- [Lists Guide](lists.md)
- [Strings Guide](strings.md)
- [Graphics Guide](graphics.md)
- [File Import Guide](files.md)

## Examples

Run example programs:
```bash
dart main.dart examples/house.repl
dart main.dart examples/demo.repl
```

Or from the REPL:
```repl
>> import examples/house
>> run examples/demo
```

## Conclusion

REPL v0.3 is a major update that transforms the language into a fully-featured scripting environment with powerful graphics capabilities. Whether you're processing data, creating visualizations, or building reusable libraries, v0.3 has the tools you need.

Happy coding! 🎉
