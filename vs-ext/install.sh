#!/bin/bash

# Well.. Simple VS Code Extension Setup Script

echo "=================================="
echo "Well.. Simple VS Code Extension"
echo "=================================="
echo ""

# Check if we're in the vs-ext directory
if [ ! -f "package.json" ]; then
    echo "Error: Please run this script from the vs-ext directory"
    exit 1
fi

echo ""
echo "Step 1: Checking for vsce (VS Code Extension Manager)..."
if command -v vsce &> /dev/null; then
    echo "✓ vsce is installed"
    
    echo ""
    echo "Step 2: Packaging extension..."
    vsce package --no-yarn
    
    if [ $? -eq 0 ]; then
        echo "✓ Extension packaged successfully!"
        echo ""
        echo "Installation options:"
        echo "  1. Install via VS Code:"
        echo "     - Open VS Code"
        echo "     - Press Ctrl+Shift+P (Cmd+Shift+P on Mac)"
        echo "     - Type 'Install from VSIX'"
        echo "     - Select the .vsix file in this directory"
        echo ""
        echo "  2. Manual installation:"
        echo "     - Copy this directory to:"
        echo "       Linux/Mac: ~/.vscode/extensions/wslang-1.0.0"
        echo "       Windows: %USERPROFILE%\\.vscode\\extensions\\wslang-1.0.0"
        echo ""
    else
        echo "✗ Failed to package extension"
        exit 1
    fi
else
    echo "⚠ vsce not found. Install it with: npm install -g @vscode/vsce"
    echo ""
    echo "Alternative: Manual installation"
    echo "  Copy this directory to:"
    echo "    Linux/Mac: ~/.vscode/extensions/wslang-1.0.0"
    echo "    Windows: %USERPROFILE%\\.vscode\\extensions\\wslang-1.0.0"
fi

echo ""
echo "Step 3: Testing"
echo "  - Open example.ws in VS Code to test syntax highlighting"
echo "  - Check the file icon in the Explorer view"
echo ""
echo "Done!"
