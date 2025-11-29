# File Import and Execution

The REPL language supports importing and running external `.repl` files.

## File Format

REPL files use the `.repl` extension and contain REPL commands, one per line.

### Example File Structure

**mylib.repl:**
```repl
# My utility library
# This is a comment

def square(x)
  result = x * x
  print(result)
end

def greet(name)
  message = "Hello, " + name + "!"
  print(message)
end

pi = 3.14159
```

## Import Command

Use `import` to load and execute a file, making its functions and variables available:

```repl
import mylib.repl
```

or simply:

```repl
import mylib
```

The `.repl` extension is added automatically if not specified.

### What Import Does

When you import a file:
1. All commands in the file are executed
2. Functions defined in the file become available
3. Variables set in the file are added to the global scope
4. The file executes in the current environment

### Example

**mathlib.repl:**
```repl
def add(a, b)
  result = a + b
  print(result)
end

def multiply(a, b)
  result = a * b
  print(result)
end

def factorial(n)
  result = 1
  for i in range(1, n + 1)
    result = result * i
  end
  print(result)
end
```

**Using the library:**
```repl
>> import mathlib
> Executing mathlib.repl
> Function add defined
> Function multiply defined
> Function factorial defined
> Finished executing mathlib.repl

>> add(5, 3)
8.0

>> multiply(4, 7)
28.0

>> factorial(5)
120.0
```

## Run Command

The `run` command is identical to `import`:

```repl
run myprogram.repl
```

or:

```repl
run myprogram
```

### Use Cases for Run

- Execute complete programs
- Run test scripts
- Load configuration files
- Execute batch operations

## Running Files from Command Line

You can also execute `.repl` files directly when starting the REPL:

```bash
dart main.dart myprogram.repl
```

This runs the file and exits (no interactive mode).

## File Examples

### Example 1: Utility Library

**utils.repl:**
```repl
# String utilities

def reverse(text)
  # Reverse a string (conceptual)
  print("Reversed: " + text)
end

def uppercase(text)
  print("UPPERCASE: " + text)
end

# Math utilities

def max(a, b)
  if a > b
    print(a)
  else
    print(b)
  end
end

def min(a, b)
  if a < b
    print(a)
  else
    print(b)
  end
end
```

**Using utils:**
```repl
import utils
max(10, 20)
min(5, 3)
```

### Example 2: Graphics Library

**shapes.repl:**
```repl
# Reusable shape functions

def drawHouse(x, y, size, color)
  # House body
  canvas.drawRectangle(x, y, size, size, color)
  
  # Roof
  roofY = y - size / 2
  canvas.drawTriangle(x, y, x + size, y, x + size / 2, roofY, "red")
  
  # Door
  doorW = size / 3
  doorH = size / 2
  doorX = x + size / 3
  doorY = y + size / 2
  canvas.drawRectangle(doorX, doorY, doorW, doorH, "brown")
end

def drawTree(x, y, size, color)
  # Trunk
  trunkW = size / 4
  trunkH = size / 2
  canvas.drawRectangle(x, y, trunkW, trunkH, "brown")
  
  # Leaves
  leafRadius = size / 3
  leafX = x + trunkW / 2
  leafY = y - leafRadius
  canvas.drawCircle(leafX, leafY, leafRadius, color)
end

def drawSun(x, y, size, color)
  canvas.drawCircle(x, y, size, color)
end
```

**Creating a scene:**
```repl
import shapes

canvas.clear()
drawSun(700, 80, 40, "yellow")
drawHouse(300, 350, 100, "beige")
drawTree(100, 400, 80, "green")
canvas.render()
canvas.exportSVG("scene.svg")
```

### Example 3: Data Processing

**data.repl:**
```repl
# Sample data
scores = [85, 92, 78, 90, 88, 95, 82]

def average(list)
  sum = 0
  for i in range(0, length(list))
    sum = sum + list[i]
  end
  avg = sum / length(list)
  print("Average: " + avg)
end

def maximum(list)
  max = list[0]
  for i in range(1, length(list))
    if list[i] > max
      max = list[i]
    end
  end
  print("Maximum: " + max)
end

def minimum(list)
  min = list[0]
  for i in range(1, length(list))
    if list[i] < min
      min = list[i]
    end
  end
  print("Minimum: " + min)
end

# Run analysis
average(scores)
maximum(scores)
minimum(scores)
```

**Running the analysis:**
```repl
run data
```

### Example 4: Configuration File

**config.repl:**
```repl
# Application configuration

appName = "MyApp"
version = "1.0.0"
debugMode = true

# Graphics settings
screenWidth = 800
screenHeight = 600
backgroundColor = "white"

# User settings
defaultUser = "admin"
maxConnections = 100
```

**Loading configuration:**
```repl
import config
print(appName)
print(version)
```

## Comments in Files

Use `#` or `//` for comments:

```repl
# This is a comment
// This is also a comment

x = 10  # Inline comment
```

## Multi-line Structures in Files

Files support multi-line structures like functions, loops, and conditionals:

```repl
def complexFunction(x)
  if x > 0
    print("Positive")
    result = x * 2
  else
    print("Non-positive")
    result = x
  end
  print(result)
end
```

## Best Practices

1. **Organize code**: Create separate files for different functionality
2. **Use comments**: Document your functions and variables
3. **Modular design**: Break large programs into smaller modules
4. **Reusable functions**: Create libraries of common operations
5. **Clear naming**: Use descriptive filenames (mathlib.repl, graphics.repl)
6. **Test separately**: Test each module before importing

## Error Handling

If a file is not found:

```repl
>> import nonexistent
Error: File 'nonexistent.repl' not found
```

If there's an error in the file:

```repl
>> import badfile
> Executing badfile.repl
Error: Invalid expression.
> Finished executing badfile.repl
```

The file execution continues even if individual commands fail.

## Example Project Structure

```
project/
├── main.repl           # Main program
├── lib/
│   ├── math.repl       # Math utilities
│   ├── string.repl     # String utilities
│   └── graphics.repl   # Graphics functions
├── data/
│   └── config.repl     # Configuration
└── examples/
    ├── demo1.repl
    └── demo2.repl
```

**main.repl:**
```repl
import lib/math
import lib/graphics
import data/config

# Your main program here
canvas.clear()
# Draw something
canvas.render()
```

Run with:
```bash
dart main.dart main.repl
```
