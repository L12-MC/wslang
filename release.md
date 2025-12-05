# Well.. Simple Release Information

## Current Version: v1.2.0

### What's New in v1.2.0

#### System Integration
- `os.command(cmd)` - Alternative syntax for executing system commands
- `sleep(ms)` - Pause execution for specified milliseconds
- `subprocess.run(cmd)` - Run commands synchronously with structured output
- `subprocess.start(cmd)` - Start commands asynchronously (non-blocking)

#### GUI Library - VISUAL RENDERING!
- **Real GUI windows** that open in your web browser
- Renders using HTML5/CSS3 with professional styling
- Local HTTP server for instant visual feedback
- `gui.window(w, h, title)` - Create styled windows
- `gui.button(x, y, w, h, text)` - Add interactive-looking buttons
- `gui.label(x, y, text)` - Add styled text labels
- `gui.input(x, y, w, h)` - Add input fields with focus effects
- `gui.show()` - Opens window in default browser
- `gui.close()` - Closes window and cleans up server
- Cross-platform support (Windows, macOS, Linux)

#### VS Code Extension Enhancements
- **IntelliSense**: Smart autocomplete for all built-in functions, keywords, variables, and classes
- **Error Detection**: Real-time syntax error detection with helpful diagnostics
- **Automatic Indentation**: Smart indent/outdent for code blocks (if, while, for, def, class, try)
- **Enhanced Syntax Highlighting**: Updated to include all new functions

### Repository

GitHub: https://github.com/L12-MC/wslang
License: See LICENSE file
