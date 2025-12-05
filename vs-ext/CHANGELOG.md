# Change Log

All notable changes to the "wslang" extension will be documented in this file.

## [1.1.0] - 2025-12-05

### Added
- **IntelliSense Support**: Smart autocomplete for all built-in functions, keywords, variables, and classes
- **Error Detection**: Real-time syntax error detection with diagnostics
  - Detects unclosed blocks (if, while, for, def, class, try)
  - Warns about missing parentheses on function calls
  - Identifies unexpected 'end' statements
- **Automatic Indentation**: Smart indent/outdent for code blocks
  - Auto-indent after block start keywords (if, while, for, def, class, try, except, finally, else)
  - Auto-outdent on 'end' keyword
  - Configurable via onEnterRules
- **Enhanced Syntax Highlighting**: Added highlighting for new v1.1.1 functions
  - System commands: os.command, subprocess.run, subprocess.start
  - GUI library: gui.window, gui.button, gui.label, gui.input, gui.show, gui.close
  - Canvas functions: Full canvas API highlighting
  - JSON functions: json.parse, json.stringify
  - Hash functions: hash.md5, hash.sha256
  - Encoding: encode.base64, decode.base64
- **Variable and Function Detection**: Extension scans document for user-defined variables and functions

### Changed
- Updated extension main entry point to `extension.js`
- Added activation events for language features
- Improved completion item details and documentation

### Fixed
- Better handling of nested blocks in error detection
- Improved pattern matching for function definitions

## [1.0.0] - 2025-11-30

### Added
- Initial release
- Syntax highlighting for Well.. Simple language
- Support for .ws and .repl file extensions
- Custom file icons for Well.. Simple files
- Auto-closing pairs for brackets and quotes
- Code folding for functions and control structures
- Line comment support with #
- Highlighting for all v1.0.3 language features:
  - Compound assignment operators (+=, -=)
  - Break statement
  - String methods (.length(), .letter())
  - All control flow keywords
  - Built-in functions
  - Package manager functions

## Future Plans

- Code snippets library
- Debugging support with breakpoints
- REPL integration within VS Code
- Hover documentation for functions
- Go to definition support
- Rename symbol refactoring
