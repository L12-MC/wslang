# Well.. Simple Language v1.0

**Well.. Simple** - A simple yet powerful scripting language with graphics, JSON, cryptography, and file I/O capabilities.

## File Extension

`.ws` - Well.. Simple files

## Tools

Well.. Simple comes with three powerful command-line tools:

- **ws** - The Well.. Simple interpreter
- **wpm** - Well.. Simple Package Manager (install libraries from Git)
- **wvm** - Well.. Simple Version Manager (manage multiple versions)

## What's New in v1.0

### Language Rename
- Renamed from "REPL v0.3" to "Well.. Simple v1.0"
- New file extension: `.ws` (still supports `.repl` for compatibility)
- Version tracking: `version` command

### Standalone Tools
- **wpm** - Separate package manager executable
- **wvm** - Separate version manager executable
- Unified build system for all tools

### New Features

#### 📦 Package Manager (wpm)
```bash
# Install packages from Git repositories (standalone tool)
wpm install https://github.com/user/package.git package-name

# List installed packages
wpm list

# Remove packages
wpm remove package-name

# Update packages
wpm update package-name
```

#### 🔄 Version Manager (wvm)
```bash
# Install a version
wvm install 1.0.0 /path/to/ws

# Switch versions
wvm use 1.0.0

# Run programs with current version
wvm run program.ws
```

#### 🔐 Cryptography Library
```ws
# MD5 hashing
hash.md5("Hello World")

# SHA256 hashing
hash.sha256("Hello World")

# Base64 encoding
encode.base64("Hello World")

# Base64 decoding
decode.base64("SGVsbG8gV29ybGQ=")
```

#### 📄 JSON Library
```ws
# Convert to JSON
data = [1, 2, 3, 4, 5]
json.stringify(data)

# Parse JSON
jsonText = "[10, 20, 30]"
json.parse(jsonText)
```

#### 📁 File I/O
```ws
# Write to file
writeFile("output.txt", "Hello, World!")

# Read from file
readFile("output.txt")
```

#### 🛡️ Error Handling
```ws
try
  x = 10
  y = 0
  result = x / y
except
  print("Error occurred!")
  print(error)
finally
  print("Cleanup code here")
end
```

## Quick Start

### Using Dart (Development)
```bash
# Interactive mode
dart main.dart

# Run a file
dart main.dart myprogram.ws
```

### Using Compiled Executable (Production)
```bash
# Build the executable (see Building section below)
./build.sh              # Linux/macOS
build.bat               # Windows

# Run the executable
./build/ws-linux        # Linux interactive mode
./build/ws-linux file.ws   # Linux run file

./build/ws-macos        # macOS interactive mode
./build/ws-macos file.ws   # macOS run file

build\ws-windows.exe    # Windows interactive mode
build\ws-windows.exe file.ws  # Windows run file
```

## Building Executables

Compile all Well.. Simple tools into standalone executables:

### Build All Tools

**Linux/macOS:**
```bash
./build-all.sh
```
Creates:
- `build/ws-linux` or `build/ws-macos` (interpreter)
- `build/wpm-linux` or `build/wpm-macos` (package manager)
- `build/wvm-linux` or `build/wvm-macos` (version manager)

**Windows:**
```batch
build-all.bat
```
Creates:
- `build\ws-windows.exe` (interpreter)
- `build\wpm-windows.exe` (package manager)
- `build\wvm-windows.exe` (version manager)

### Build Individual Tools

```bash
# Build just the interpreter
./build.sh

# Build just wpm
dart compile exe wpm.dart -o build/wpm-linux

# Build just wvm
dart compile exe wvm.dart -o build/wvm-linux
```

**Note**: Cross-compilation requires building on each target platform. See [docs/building.md](docs/building.md) for detailed instructions.

### System-Wide Installation

After building, install all tools system-wide:

**Linux/macOS:**
```bash
sudo cp build/ws-linux /usr/local/bin/ws
sudo cp build/wpm-linux /usr/local/bin/wpm
sudo cp build/wvm-linux /usr/local/bin/wvm
sudo chmod +x /usr/local/bin/{ws,wpm,wvm}
```

**Windows:**
1. Copy all `.exe` files to `C:\Program Files\WellSimple\`
2. Add the directory to your PATH
3. Optionally rename: `ws-windows.exe` → `ws.exe`, etc.

Then use from anywhere:
```bash
ws program.ws              # Run programs
wpm install <url>          # Install packages
wvm install 1.0.0 <path>   # Manage versions
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
- [Quick Reference](QUICKREF.md)

## Example Programs

Check the `examples/` directory:
- `features.ws` - All new features demo
- `package-demo.ws` - Package manager demonstration
- `test-pkg-manager.ws` - Package manager testing
- `house.repl` - Graphics demo (still works)
- `mathlib.repl` - Math library (still works)

Check the `example-package/` directory:
- Example package structure with `math.ws` and `strings.ws`
- Demonstrates how to create your own packages

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

**Well.. Simple** - Because programming should be... well, simple! 🚀
