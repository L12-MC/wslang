# Quick Start: Installing the Well.. Simple VS Code Extension

## Method 1: Simple Copy (Recommended for Quick Setup)

```bash
# From the project root
cp -r vs-ext ~/.vscode/extensions/wslang-1.0.0

# Restart VS Code or reload window
# In VS Code: Ctrl+Shift+P → "Developer: Reload Window"
```

## Method 2: Using the Install Script

```bash
cd vs-ext
./install.sh
```

## Method 3: Package as VSIX (For Distribution)

```bash
cd vs-ext

# Install vsce (one time)
npm install -g @vscode/vsce

# Create .vsix package
vsce package

# Install the .vsix in VS Code:
# 1. Ctrl+Shift+P (Cmd+Shift+P on Mac)
# 2. Type "Install from VSIX"
# 3. Select wslang-1.0.0.vsix
```

## Verify Installation

1. Open VS Code
2. Create a new file: `test.ws`
3. Type some Well.. Simple code:
   ```
   def hello()
     print("Hello!")
   end
   ```
4. Check that:
   - Keywords are highlighted in color
   - File icon shows "WS" icon in Explorer
   - Auto-closing works for brackets

## Troubleshooting

**Syntax highlighting not working?**
- Verify file extension is `.ws` or `.repl`
- Check language mode (bottom-right of VS Code)
- Reload window: Ctrl+Shift+P → "Reload Window"

**Icon not showing?**
- Make sure `images/wslang.png` exists
- Check File Icon Theme is set to "Well.. Simple Icons"
- Settings → File Icon Theme → Select "Well.. Simple Icons"

**Extension not found?**
- Check extension location: `~/.vscode/extensions/wslang-1.0.0/`
- Verify `package.json` exists in that folder
- Check VS Code version is 1.80.0 or higher

## Next Steps

- Open `example.ws` to see syntax highlighting examples
- Read `README.md` for full documentation
- Check `EXTENSION_INFO.md` for technical details

---

**That's it!** Start writing Well.. Simple code with full VS Code support! 🎉
