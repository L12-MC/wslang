#!/bin/bash
# Build script for Well.. Simple interpreter
# Compiles for the current platform

echo "Building Well.. Simple v1.0"
echo "=============================="
echo ""

# Create build directory
mkdir -p build

# Detect platform
PLATFORM=$(uname -s)
case "$PLATFORM" in
    Linux*)
        echo "Detected platform: Linux"
        OUTPUT="build/wslang-linux"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        echo "Detected platform: Windows"
        OUTPUT="build/wslang-win.exe"
        ;;
    *)
        echo "Unknown platform: $PLATFORM"
        OUTPUT="build/ws"
        ;;
esac
echo ""

# Build for current platform
echo "Building executable..."
dart compile exe main.dart -o "$OUTPUT"
dart compile exe main.dart --target-os windows -o "build/wslang.exe"

if [ $? -eq 0 ]; then
    echo ""
    echo "=============================="
    echo "✓ Build successful!"
else
    echo ""
    echo "✗ Build failed"
    exit 1
fi
