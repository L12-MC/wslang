# VS Code Extension for Well.. Simple

## 📦 What's Included

The `vs-ext` folder contains a complete VS Code extension for Well.. Simple language support.

### Directory Structure

```
vs-ext/
├── package.json                    # Extension manifest
├── language-configuration.json     # Language configuration (brackets, comments, etc.)
├── README.md                       # Extension documentation
├── CHANGELOG.md                    # Version history
├── BUILDING.md                     # Build and installation instructions
├── install.sh                      # Installation helper script
├── example.ws                      # Example file for testing
├── .vscodeignore                   # Files to exclude from package
├── syntaxes/
│   └── wslang.tmLanguage.json     # Syntax highlighting grammar
├── images/
│   ├── wslang.svg                 # Icon source (SVG)
│   └── wslang.png                 # Icon for extension (128x128)
└── fileicons/
    └── wslang-icon-theme.json     # File icon theme definition
```

## ✨ Features

### 1. **Syntax Highlighting**
Complete syntax highlighting for:
- Keywords: `if`, `else`, `while`, `for`, `def`, `class`, `return`, `break`, etc.
- Operators: `+`, `-`, `*`, `/`, `+=`, `-=`, `==`, `!=`, `<`, `>`, etc.
- Strings: Single and double quoted with escape sequences
- Numbers: Integers and floating-point
- Comments: Line comments with `#`
- Functions: Built-in and user-defined
- String methods: `.length()`, `.letter()`
- Booleans: `true`, `false`, `null`

### 2. **File Icons**
- Custom icon for `.ws` and `.repl` files
- Blue and purple "WS" icon design
- Visible in VS Code Explorer

### 3. **Language Features**
- Auto-closing brackets and quotes
- Code folding for functions and control structures
- Comment toggling with `Ctrl+/`
- Proper word boundaries for variables

### 4. **File Associations**
Automatic language detection for:
- `.ws` files (Well.. Simple scripts)
- `.repl` files (Well.. Simple REPL files)

## 🚀 Installation Options

### Option 1: Quick Install (Manual)

```bash
# Copy extension to VS Code extensions folder
cp -r vs-ext ~/.vscode/extensions/wslang-1.0.0

# Restart VS Code
```

### Option 2: Package and Install

```bash
cd vs-ext

# Install vsce if not already installed
npm install -g @vscode/vsce

# Package the extension
vsce package

# Install via VS Code:
# 1. Press Ctrl+Shift+P
# 2. Type "Install from VSIX"
# 3. Select the .vsix file
```

### Option 3: Use Install Script

```bash
cd vs-ext
./install.sh
```

## 📝 Testing

1. Open the `example.ws` file in VS Code
2. Verify syntax highlighting is working:
   - Keywords should be colored
   - Strings should be highlighted
   - Comments should be distinct
3. Check the file icon in the Explorer sidebar
4. Try typing code and verify auto-completion of brackets

## 🎨 Icon Design

The extension includes a custom icon:
- **Colors**: Blue (#2563EB) with purple accent (#A855F7)
- **Design**: "WS" text with accent dot
- **Format**: PNG (128x128) and SVG source
- **Location**: `images/wslang.png`

## 📚 Language Configuration

The extension provides:
- **Line comments**: `#`
- **Brackets**: `()`, `[]`
- **Auto-closing pairs**: Brackets, quotes
- **Folding markers**: Functions, loops, classes (end with `end`)

## 🔧 Customization

### To modify syntax highlighting:
Edit `syntaxes/wslang.tmLanguage.json`

### To change file icon:
Replace `images/wslang.png` with your own icon

### To update language features:
Edit `language-configuration.json`

## 📦 Extension Metadata

- **Name**: wslang
- **Display Name**: Well.. Simple Language Support
- **Version**: 1.0.0
- **Publisher**: wslang (update in package.json)
- **Repository**: https://github.com/L12-MC/wslang

## 🔍 Supported Language Features

### Keywords
```
if, else, while, for, in, range, end, break, return
try, except, finally, def, class, import
and, or, not
```

### Built-in Functions
```
print, input, len, type, str, int, float
list, dict, encode, decode, hash, sleep, version
pkg.install, pkg.list, pkg.remove
```

### String Methods
```
.length()     # Get string length
.letter(n)    # Get character at index n
```

### Operators
```
Arithmetic: +, -, *, /, %
Compound: +=, -=
Comparison: ==, !=, <, >, <=, >=
Assignment: =
```

## 📋 Requirements

- VS Code 1.80.0 or higher
- Well.. Simple interpreter (for running code)

## 🐛 Known Issues

None currently. File issues at: https://github.com/L12-MC/wslang/issues

## 🚀 Future Enhancements

Potential future features:
- IntelliSense/autocomplete
- Code snippets
- Error detection and linting
- Integrated debugger
- REPL integration in VS Code terminal
- Hover documentation
- Go to definition

## 📄 Files Description

| File | Purpose |
|------|---------|
| `package.json` | Extension manifest with metadata and contributions |
| `language-configuration.json` | Language-specific settings (brackets, comments) |
| `wslang.tmLanguage.json` | TextMate grammar for syntax highlighting |
| `wslang-icon-theme.json` | File icon theme mapping |
| `wslang.png/svg` | Extension and file icons |
| `README.md` | User-facing documentation |
| `CHANGELOG.md` | Version history |
| `BUILDING.md` | Build and installation guide |
| `example.ws` | Sample code for testing |

## ✅ Verification Checklist

- [x] Syntax highlighting for all language features
- [x] File icon for .ws and .repl files
- [x] Auto-closing brackets and quotes
- [x] Code folding support
- [x] Comment toggling
- [x] Example file included
- [x] Documentation complete
- [x] Icon created (PNG and SVG)
- [x] Extension added to .gitignore

## 🎉 Success!

The VS Code extension is now ready to use! Open any `.ws` file in VS Code to see syntax highlighting in action.

---

**Note**: The `vs-ext` folder is excluded from git via `.gitignore` as requested.
