# Well.. Simple Language Extension for VS Code

This extension provides syntax highlighting and language support for Well.. Simple (.ws) files.

## Features

- **Syntax Highlighting**: Full syntax highlighting for Well.. Simple language
- **File Icons**: Custom icons for .ws and .repl files
- **Auto-completion**: Bracket and quote auto-closing
- **Code Folding**: Support for folding function and control structure blocks
- **Comments**: Line comment support with `#`

## Supported File Extensions

- `.ws` - Well.. Simple script files
- `.wsx` - Well.. Simple Library files

## Language Features

### Highlighted Elements

- **Keywords**: `if`, `else`, `while`, `for`, `def`, `class`, `return`, `break`, `try`, `except`, `finally`, `import`
- **Operators**: `+`, `-`, `*`, `/`, `%`, `==`, `!=`, `<`, `>`, `<=`, `>=`, `+=`, `-=`
- **Booleans**: `true`, `false`, `null`
- **Strings**: Single and double quoted strings with escape sequences
- **Numbers**: Integer and floating-point numbers
- **Functions**: Built-in functions and user-defined functions
- **Comments**: Line comments starting with `#`

### Built-in Functions

- `print()`, `input()`, `len()`, `type()`
- `str()`, `int()`, `float()`
- `list()`, `dict()`
- `encode()`, `decode()`, `hash()`
- `sleep()`, `version()`
- `pkg.install()`, `pkg.list()`, `pkg.remove()`

### String Methods

- `.length()` - Get string length
- `.letter(index)` - Get character at index

## Installation

### From Source

1. Copy the `vs-ext` folder to your VS Code extensions directory:
   - **Windows**: `%USERPROFILE%\.vscode\extensions`
   - **macOS/Linux**: `~/.vscode/extensions`

2. Restart VS Code

3. Open a `.ws` file and enjoy syntax highlighting!

### Manual Installation

1. Open VS Code
2. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS)
3. Type "Install from VSIX" and select the command
4. Browse to the `.vsix` file (if packaged)
5. Restart VS Code

## Usage

Simply open any `.ws` or `.repl` file and the syntax highlighting will be automatically applied.

### Example Code

```wslang
# This is a comment
def greet(name)
  print("Hello, " + name)
end

# Using new v1.0.3 features
counter = 0
counter += 5  # Compound assignment

text = "Programming"
for i in range(0, text.length())
  letter = text.letter(i)
  print(letter)
  
  if letter == "g"
    break  # Exit loop early
  end
end
```

## Requirements

- VS Code 1.80.0 or higher

## Extension Settings

This extension contributes the following settings:

- File associations for `.ws` and `.repl` files
- Custom file icons
- Syntax highlighting rules

## Known Issues

- Icon file should be a PNG. Currently using SVG as placeholder.

## Release Notes

### 1.0.0

Initial release with:
- Complete syntax highlighting
- File icon support
- Auto-closing pairs
- Code folding
- Support for all Well.. Simple v1.0.3 features

## Contributing

Issues and pull requests are welcome at [https://github.com/L12-MC/wslang](https://github.com/L12-MC/wslang)

## License

This extension is provided as-is for the Well.. Simple language community.

---

**Enjoy coding with Well.. Simple!**
