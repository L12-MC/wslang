# Well.. Simple v1.0 Quick Reference

## Variables
```repl
x = 10                    # Number
name = "Alice"            # String
flag = true               # Boolean
list = [1, 2, 3]         # List
```

## Math Operations
```repl
5 + 3                     # Addition
10 - 4                    # Subtraction
6 * 7                     # Multiplication
20 / 4                    # Division
17 % 5                    # Modulo
(5 + 3) * 2              # Parentheses
```

## Strings
```repl
text = "Hello"
str = "World"
combined = text + " " + str          # Concatenation
parts = split("a,b,c", ",")         # Split
len = length("Hello")                # Length (5.0)
```

## Lists
```repl
nums = [1, 2, 3, 4, 5]              # Create list
print(nums[0])                       # Access element (1.0)
append(nums, 6)                      # Append element
len = length(nums)                   # Get length (6.0)
```

## Control Flow
```repl
# If statement
if x > 10
  print("Greater than 10")
else
  print("Not greater")
end

# While loop
count = 0
while count < 5
  print(count)
  count = count + 1
end

# For loop
for i in range(0, 10)
  print(i)
end
```

## Functions
```repl
# Define function
def greet(name)
  message = "Hello, " + name
  print(message)
end

# Call function
greet("Alice")
```

## Files
```repl
import mylib                         # Import file
import mylib.repl                    # Same thing
run myprogram                        # Run program
import lib/utils                     # Import from folder
```

**Command line:**
```bash
dart main.dart myprogram.repl
```

## Canvas Graphics

### Setup
```repl
canvas.clear()                       # Clear canvas
```

### Draw Shapes
```repl
canvas.drawCircle(x, y, radius, "color")
canvas.drawRectangle(x, y, w, h, "color")
canvas.drawTriangle(x1, y1, x2, y2, x3, y3, "color")
canvas.drawLine(x1, y1, x2, y2, "color")
canvas.drawPolygon([x1, y1, x2, y2, ...], "color")
```

### Render & Export
```repl
canvas.render()                      # Show in console
canvas.exportSVG("file.svg")        # Save to file
```

### Example
```repl
canvas.clear()
canvas.drawCircle(100, 100, 50, "red")
canvas.drawRectangle(200, 150, 100, 80, "blue")
canvas.render()
canvas.exportSVG("shapes.svg")
```

## Colors
Common: `"red"`, `"blue"`, `"green"`, `"yellow"`, `"orange"`, `"purple"`, `"pink"`, `"brown"`, `"gray"`, `"black"`, `"white"`

Extended: `"cyan"`, `"magenta"`, `"lightblue"`, `"darkgreen"`, `"beige"`

Hex: `"#FF0000"`, `"#00FF00"`, `"#0000FF"`

## Built-in Functions
```repl
print(value)                         # Print to console
split(str, delimiter)                # Split string
append(list, item)                   # Append to list
length(str_or_list)                  # Get length
```

## Comparison Operators
```repl
x < 10                               # Less than
x > 10                               # Greater than
x <= 10                              # Less or equal
x >= 10                              # Greater or equal
x == 10                              # Equal to
x != 10                              # Not equal
```

## Comments
```repl
# This is a comment
x = 10  # Inline comment
```

## Common Patterns

### Parse CSV
```repl
data = "Alice,30,Engineer"
fields = split(data, ",")
name = fields[0]
age = fields[1]
job = fields[2]
```

### Build String
```repl
name = "Bob"
age = 25
message = "My name is " + name + " and I'm " + age
```

### List Average
```repl
nums = [10, 20, 30, 40, 50]
sum = 0
for i in range(0, length(nums))
  sum = sum + nums[i]
end
avg = sum / length(nums)
print(avg)
```

### Draw Scene
```repl
import examples/shapes
canvas.clear()
drawHouse(300, 350, 100, "beige")
drawTree(100, 400, 80, "green")
canvas.render()
canvas.exportSVG("scene.svg")
```

## Package Manager (v1.0)
```ws
# Install package from Git
pkg.install("https://github.com/user/lib.git", "libname")

# List installed packages
pkg.list()

# Remove package
pkg.remove("libname")

# Import from package
import libname/file.ws

# Check version
version                              # Well.. Simple v1.0.0
```

## JSON (v1.0)
```ws
# Convert to JSON
data = [1, 2, 3]
jsonText = json.stringify(data)      # "[1.0,2.0,3.0]"

# Parse JSON
parsed = json.parse("[10,20,30]")    # Returns list
```

## Cryptography (v1.0)
```ws
# Hashing
hash.md5("password")                 # MD5 hash
hash.sha256("password")              # SHA256 hash

# Base64
encoded = encode.base64("secret")    # Encode
decoded = decode.base64(encoded)     # Decode
```

## File I/O (v1.0)
```ws
# Write file
writeFile("data.txt", "Hello!")

# Read file
readFile("data.txt")
```

## Error Handling (v1.0)
```ws
try
  x = 10 / 0
except
  print("Error: " + error)
finally
  print("Cleanup")
end
```

## Interactive Mode
```ws
>> help                              # Show help
>> version                           # Show version
>> exit()                            # Exit REPL
>> quit()                            # Also exits
```

## Tips
- Use `.ws` extension for files (`.repl` also works)
- Canvas is 800x600 by default
- Lists and strings are 0-indexed
- All numbers are floats (10 becomes 10.0)
- Use `print()` to see values
- Create packages for reusable code
- Export canvas to SVG for visual output
- Install packages with Git URLs
- Use try/except for error handling

## Examples
See `examples/` directory:
- `features.ws` - All v1.0 features
- `package-demo.ws` - Package manager demo
- `house.repl` - House scene (graphics)
- `mathlib.repl` - Math functions
- `strings.repl` - String demos
- `shapes.repl` - Shape library

## Documentation
- [Getting Started](docs/getting-started.md)
- [Package Manager](docs/package-manager.md) ⭐ New!
- [Building Executables](docs/building.md) ⭐ New!
- [Error Handling](docs/error-handling.md) ⭐ New!
- [File I/O](docs/file-io.md) ⭐ New!
- [JSON](docs/json.md) ⭐ New!
- [Cryptography](docs/cryptography.md) ⭐ New!
- [Strings Guide](docs/strings.md)
- [Lists Guide](docs/lists.md)
- [Graphics Guide](docs/graphics.md)
