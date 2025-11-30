# Building and Installing the Extension

## Prerequisites

- Node.js and npm installed
- Visual Studio Code Extension Manager (`vsce`)

## Install vsce

```bash
npm install -g @vscode/vsce
```

## Package the Extension

1. Navigate to the vs-ext directory:
   ```bash
   cd vs-ext
   ```

2. Install dependencies (if any):
   ```bash
   npm install
   ```

3. Package the extension:
   ```bash
   vsce package
   ```

   This will create a `.vsix` file (e.g., `wslang-1.0.0.vsix`)

## Install the Extension

### Method 1: From VSIX File

1. Open VS Code
2. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS)
3. Type "Install from VSIX"
4. Select the `.vsix` file you just created
5. Restart VS Code

### Method 2: Manual Installation (Development)

1. Copy the entire `vs-ext` folder to:
   - **Windows**: `%USERPROFILE%\.vscode\extensions\wslang-1.0.0`
   - **macOS/Linux**: `~/.vscode/extensions/wslang-1.0.0`

2. Restart VS Code

### Method 3: Development Mode

1. Open VS Code
2. Open the `vs-ext` folder
3. Press `F5` to launch a new VS Code window with the extension loaded
4. Test your extension in the new window

## Convert SVG Icon to PNG

The extension currently uses an SVG icon. For best results, convert it to PNG:

```bash
# Using ImageMagick
convert -background none -size 128x128 images/wslang.svg images/wslang.png

# Or using Inkscape
inkscape images/wslang.svg --export-png=images/wslang.png --export-width=128 --export-height=128
```

## Testing

1. Create a test `.ws` file
2. Open it in VS Code
3. Verify syntax highlighting works
4. Check that the file icon appears in the explorer

## Publishing (Optional)

To publish to the VS Code Marketplace:

1. Create a publisher account at https://marketplace.visualstudio.com/
2. Get a Personal Access Token
3. Login with vsce:
   ```bash
   vsce login <publisher-name>
   ```
4. Publish:
   ```bash
   vsce publish
   ```

## Troubleshooting

### Icon not showing
- Make sure `wslang.png` exists in the `images` folder
- Try converting the SVG to PNG as described above

### Syntax highlighting not working
- Check that the file has `.ws` extension
- Reload VS Code window (`Ctrl+R` or `Cmd+R`)
- Check the language mode in the bottom-right corner

### Extension not loading
- Check for errors in the Developer Console (`Help > Toggle Developer Tools`)
- Make sure the extension folder structure is correct
