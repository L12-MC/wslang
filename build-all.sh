#!/bin/bash
# Build script for Well.. Simple tools
# Compiles ws, wpm, and wvm for the current platform

echo "Building Well.. Simple Tools v1.0"
echo "======================================"
echo ""

# Create build directory
mkdir -p build

# Detect platform
PLATFORM=$(uname -s)
case "$PLATFORM" in
    Linux*)
        echo "Detected platform: Linux"
        WS_OUTPUT="build/ws-linux"
        WPM_OUTPUT="build/wpm-linux"
        WVM_OUTPUT="build/wvm-linux"
        ;;
    Darwin*)
        echo "Detected platform: macOS"
        WS_OUTPUT="build/ws-macos"
        WPM_OUTPUT="build/wpm-macos"
        WVM_OUTPUT="build/wvm-macos"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        echo "Detected platform: Windows"
        WS_OUTPUT="build/ws-windows.exe"
        WPM_OUTPUT="build/wpm-windows.exe"
        WVM_OUTPUT="build/wvm-windows.exe"
        ;;
    *)
        echo "Unknown platform: $PLATFORM"
        WS_OUTPUT="build/ws"
        WPM_OUTPUT="build/wpm"
        WVM_OUTPUT="build/wvm"
        ;;
esac
echo ""

# Build Well.. Simple interpreter
echo "Building Well.. Simple interpreter..."
dart compile exe main.dart -o "$WS_OUTPUT"
if [ $? -eq 0 ]; then
    echo "✓ ws compiled: $WS_OUTPUT"
else
    echo "✗ ws compilation failed"
    exit 1
fi
echo ""

# Build wpm (Package Manager)
echo "Building wpm (Package Manager)..."
dart compile exe wpm.dart -o "$WPM_OUTPUT"
if [ $? -eq 0 ]; then
    echo "✓ wpm compiled: $WPM_OUTPUT"
else
    echo "✗ wpm compilation failed"
    exit 1
fi
echo ""

# Build wvm (Version Manager)
echo "Building wvm (Version Manager)..."
dart compile exe wvm.dart -o "$WVM_OUTPUT"
if [ $? -eq 0 ]; then
    echo "✓ wvm compiled: $WVM_OUTPUT"
else
    echo "✗ wvm compilation failed"
    exit 1
fi
echo ""

echo "======================================"
echo "✓ Build successful!"
echo ""
echo "Executables in build/ directory:"
echo "  - $WS_OUTPUT  (Well.. Simple interpreter)"
echo "  - $WPM_OUTPUT (Package manager)"
echo "  - $WVM_OUTPUT (Version manager)"
echo ""
echo "To install system-wide (Linux/macOS):"
echo "  sudo cp $WS_OUTPUT /usr/local/bin/ws"
echo "  sudo cp $WPM_OUTPUT /usr/local/bin/wpm"
echo "  sudo cp $WVM_OUTPUT /usr/local/bin/wvm"
echo "  sudo chmod +x /usr/local/bin/{ws,wpm,wvm}"
echo ""
echo "Usage:"
echo "  ws program.ws     # Run Well.. Simple programs"
echo "  wpm install URL   # Install packages"
echo "  wvm install 1.0.0 /path/to/ws  # Manage versions"
