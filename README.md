# Well Simple Language v1.2.1

**Well Simple** - A Well... Simple yet powerful scripting language with graphics, JSON, cryptography, and file I/O capabilities.

## File Extension

`.ws` - Well Simple files

## Tools

Well Simple comes with three powerful command-line tools:

- **ws** - The Well.. Simple interpreter
- **wpm** - WS Package Manager (install libraries from Git)
- (wip)**wvm** - WS Version Manager (manage multiple versions)

## What's New in v1.2.1

### Latest Features

#### Custom CSS On GUI's
```ws
gui.css(".button {color: green !important;}")
```

#### Centered Labels and Titles

```
gui.labelcenter(150, "Hello!")
```

```
gui.title("Hello!")
```

## Quick Start

```bash
# Run the executable
./build/wslang-linux       # Linux interactive mode
./build/wslang-linux file.ws   # Linux run file

build\wslang-win.exe    # Windows interactive mode
build\wslang-win.exe file.ws  # Windows run file
```

## Building Executable

Build WSLang to executable

**Linux/macOS:**
```bash
./build.sh
```

**Windows:**
```batch
build.bat
```

## Core Features

### Variables
```ws
x = 10
name = "Alice"
list = [1, 2, 3]
flag = true
```

### String Operations
```ws
first = "Hello"
second = "World"
greeting = first + " " + second
parts = split("a,b,c", ",")
```

### Lists
```ws
numbers = [1, 2, 3, 4, 5]
append(numbers, 6)
print(numbers[0])
len = length(numbers)
```

### Control Flow
```ws
# If statement
if x > 10
  print("Greater")
else
  print("Smaller")
end

# While loop
while x < 5
  x = x + 1
end

# For loop
for i in range(0, 10)
  print(i)
end
```

### Functions
```ws
def greet(name)
  message = "Hello, " + name
  print(message)
end

greet("Alice")
```

### Error Handling
```ws
try
  # Code that might fail
  readFile("nonexistent.txt")
except
  # Handle error
  print("File not found!")
  print(error)
finally
  # Always executes
  print("Done")
end
```

### Graphics
```ws
canvas.clear()
canvas.drawCircle(100, 100, 50, "red")
canvas.drawRectangle(200, 200, 100, 80, "blue")
canvas.render()
canvas.exportSVG("output.svg")
```

### JSON Operations
```ws
# Serialize
obj = [1, 2, 3]
json.stringify(obj)

# Deserialize
text = "[1, 2, 3]"
json.parse(text)
```

### Cryptography
```ws
# Hashing
hash.md5("password")
hash.sha256("password")

# Encoding
encoded = encode.base64("secret")
decoded = decode.base64(encoded)
```

### File Operations
```ws
# Write
writeFile("data.txt", "Hello!")

# Read
content = readFile("data.txt")
```

## Documentation

### Tools
- [wpm - Package Manager](docs/wpm.md) - **Standalone package manager**
- [wvm - Version Manager](docs/wvm.md) - **Manage multiple versions**
- [Building Executables](docs/building.md) - **Compile for Linux/macOS/Windows**

### Language Reference
- [Getting Started](docs/getting-started.md)
- [Variables and Data Types](docs/variables.md)
- [Strings](docs/strings.md)
- [Lists](docs/lists.md)
- [Control Flow](docs/control-flow.md)
- [Functions](docs/functions.md)
- [Error Handling](docs/error-handling.md)
- [File I/O](docs/file-io.md)
- [JSON](docs/json.md)
- [Cryptography](docs/cryptography.md)
- [Graphics](docs/graphics.md)

## Example Programs

Check the `examples/` directory:
- `features.ws` - All new features demo
- `package-demo.ws` - Package manager demonstration
- `test-pkg-manager.ws` - Package manager testing

## Philosophy

**Well.. Simple** aims to be:
- **Simple** - Easy to learn and use
- **Powerful** - Rich built-in libraries
- **Practical** - Real-world file I/O and data handling
- **Creative** - Graphics engine for visualizations
- **Secure** - Built-in cryptography support
- **Extensible** - Git-based package manager for sharing libraries

## Help

Type `help` in the interactive mode:
```ws
>> help
```

## Exit

```ws
exit()
quit()
```

## License

Open source and free to use.

---

**Well.. Simple** - Because programming should be... well, simple!
