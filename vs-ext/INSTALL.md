# Installing the Well.. Simple VS Code Extension

This guide will help you install and configure the Well.. Simple language extension for Visual Studio Code.

## Prerequisites

- Visual Studio Code 1.80.0 or higher
- Node.js (optional, only needed for packaging)

## Installation Methods

### Method 1: Copy Extension Folder (Recommended for Development)

1. Locate your VS Code extensions directory:
   - **Windows**: `%USERPROFILE%\.vscode\extensions`
   - **macOS/Linux**: `~/.vscode/extensions`

2. Copy the entire `vs-ext` folder to the extensions directory and rename it:
   ```
   wslang-extension
   ```

3. Restart VS Code

4. Open a `.ws` file to verify the extension is working

### Method 2: Package as VSIX (For Distribution)

1. Install vsce (VS Code Extension CLI):
   ```bash
   npm install -g @vscode/vsce
   ```

2. Navigate to the `vs-ext` directory:
   ```bash
   cd vs-ext
   ```

3. Package the extension:
   ```bash
   vsce package
   ```

4. This creates a `.vsix` file (e.g., `wslang-1.1.0.vsix`)

5. Install the VSIX in VS Code:
   - Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
   - Type "Extensions: Install from VSIX"
   - Select the `.vsix` file
   - Restart VS Code

### Method 3: Symlink (For Active Development)

1. Create a symlink to the extension folder:

   **Windows (Command Prompt as Administrator):**
   ```cmd
   mklink /D "%USERPROFILE%\.vscode\extensions\wslang-extension" "C:\path\to\wslang\vs-ext"
   ```

   **macOS/Linux:**
   ```bash
   ln -s /path/to/wslang/vs-ext ~/.vscode/extensions/wslang-extension
   ```

2. Restart VS Code or reload the window

## Verifying Installation

1. Open VS Code
2. Create a new file with `.ws` extension
3. Type `print` and press `Ctrl+Space` to trigger autocomplete
4. You should see IntelliSense suggestions

## Features to Test

### 1. Syntax Highlighting

Create a test file `test.ws`:

```wslang
# This should be highlighted as a comment
def greet(name)
    print("Hello, " + name)
end

x = 10
if x > 5
    print("Greater than 5")
end
```

Verify that keywords, strings, numbers, and comments are colored correctly.

### 2. IntelliSense

1. Type `gui.` and wait - you should see autocomplete options:
   - gui.window
   - gui.button
   - gui.label
   - gui.input
   - gui.show
   - gui.close

2. Type `os.` - you should see:
   - os.command

3. Type `subprocess.` - you should see:
   - subprocess.run
   - subprocess.start

### 3. Error Detection

Create a file with intentional errors:

```wslang
if x > 5
    print("test")
# Missing 'end' - should show error squiggle

def test()
    print("test")
end
end
# Extra 'end' - should show error
```

Errors should appear with red squiggles.

### 4. Automatic Indentation

1. Type `if x > 5` and press Enter
2. The next line should automatically indent
3. Type `end` and press Enter
4. The cursor should outdent back

## Troubleshooting

### Extension Not Loading

1. Check the extension is in the correct directory:
   ```
   ~/.vscode/extensions/wslang-extension/
   ```

2. Verify the extension has a `package.json` file

3. Check the VS Code Developer Tools:
   - Help > Toggle Developer Tools
   - Look for errors in the Console

### IntelliSense Not Working

1. Ensure the file has `.ws` extension
2. Try reloading the window: `Ctrl+Shift+P` > "Developer: Reload Window"
3. Check if `extension.js` exists in the extension folder

### Syntax Highlighting Issues

1. Verify `syntaxes/wslang.tmLanguage.json` exists
2. Check `package.json` has correct `grammars` configuration
3. Try a different color theme

### Indentation Not Working

1. Check `language-configuration.json` exists
2. Verify VS Code settings aren't overriding indentation
3. Set language mode explicitly: Click language in status bar > "Well.. Simple"

## Updating the Extension

### After Code Changes

1. If you installed via copy or VSIX:
   - Copy updated files
   - Reload VS Code window

2. If you installed via symlink:
   - Just reload VS Code window (changes are immediate)

### Repackaging

```bash
cd vs-ext
vsce package
```

This creates a new `.vsix` file with updated version.

## Uninstalling

### Manual Removal

Delete the extension folder:
```bash
# Windows
rmdir /s "%USERPROFILE%\.vscode\extensions\wslang-extension"

# macOS/Linux
rm -rf ~/.vscode/extensions/wslang-extension
```

### Via VS Code

1. Open Extensions view (`Ctrl+Shift+X`)
2. Search for "Well.. Simple"
3. Click gear icon > Uninstall

## Development Tips

### Live Debugging

1. Open the `vs-ext` folder in VS Code
2. Press `F5` to launch Extension Development Host
3. Changes to `extension.js` require reloading the development window

### Testing Changes

1. Modify `extension.js`, `package.json`, or language files
2. Press `Ctrl+Shift+P` > "Developer: Reload Window"
3. Test the changes in a `.ws` file

### Adding New Features

1. **Autocomplete**: Edit `extension.js` > Add to completion arrays
2. **Syntax Highlighting**: Edit `syntaxes/wslang.tmLanguage.json`
3. **Indentation**: Edit `language-configuration.json`
4. **Error Detection**: Edit `updateDiagnostics()` in `extension.js`

## Publishing to Marketplace (Future)

1. Create a publisher account on [Visual Studio Marketplace](https://marketplace.visualstudio.com/)
2. Get a Personal Access Token from Azure DevOps
3. Publish:
   ```bash
   vsce publish
   ```

## Support

For issues or questions:
- GitHub Issues: https://github.com/L12-MC/wslang/issues
- Check `EXTENSION_INFO.md` for technical details
- See `CHANGELOG.md` for version history
