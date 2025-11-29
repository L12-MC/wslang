# Building Well.. Simple

This guide explains how to compile the Well.. Simple interpreter into standalone executables for different platforms.

## Prerequisites

- Dart SDK 3.0 or later
- Build scripts: `build.sh` (Linux/macOS) or `build.bat` (Windows)

## Quick Start

### On Linux or macOS
```bash
./build.sh
```

### On Windows
```batch
build.bat
```

The compiled executable will be in the `build/` directory.

## Build Output

Each platform produces a different executable:

- **Linux**: `build/ws-linux`
- **macOS**: `build/ws-macos`
- **Windows**: `build/ws-windows.exe`

## Cross-Platform Compilation

Dart's `compile exe` command can only compile for the current platform (as of Dart 3.x). To create executables for all platforms:

1. **On Linux**: Run `./build.sh` → produces `build/ws-linux`
2. **On macOS**: Run `./build.sh` → produces `build/ws-macos`
3. **On Windows**: Run `build.bat` → produces `build/ws-windows.exe`

## Using the Compiled Executable

### Interactive Mode (REPL)
```bash
# Linux
./build/ws-linux

# macOS
./build/ws-macos

# Windows
build\ws-windows.exe
```

### Run a Script File
```bash
# Linux
./build/ws-linux program.ws

# macOS
./build/ws-macos program.ws

# Windows
build\ws-windows.exe program.ws
```

## Installation

After building, you can install the executable system-wide:

### Linux
```bash
sudo cp build/ws-linux /usr/local/bin/ws
sudo chmod +x /usr/local/bin/ws
```

Then run from anywhere:
```bash
ws program.ws
```

### macOS
```bash
sudo cp build/ws-macos /usr/local/bin/ws
sudo chmod +x /usr/local/bin/ws
```

Then run from anywhere:
```bash
ws program.ws
```

### Windows
1. Copy `build\ws-windows.exe` to a directory (e.g., `C:\Program Files\WellSimple\`)
2. Add that directory to your PATH environment variable
3. Rename to `ws.exe` if desired

Then run from anywhere:
```batch
ws program.ws
```

## Build Script Details

### build.sh (Linux/macOS)

The bash script:
1. Detects the current platform (Linux or macOS)
2. Creates a `build/` directory
3. Compiles `main.dart` to a native executable
4. Outputs the result to `build/ws-linux` or `build/ws-macos`

### build.bat (Windows)

The batch script:
1. Creates a `build\` directory
2. Compiles `main.dart` to a native executable
3. Outputs the result to `build\ws-windows.exe`

## Manual Compilation

You can also compile manually:

### Linux
```bash
dart compile exe main.dart -o build/ws-linux
```

### macOS
```bash
dart compile exe main.dart -o build/ws-macos
```

### Windows
```batch
dart compile exe main.dart -o build\ws-windows.exe
```

## Troubleshooting

### Build fails with "dart: command not found"
- Install the Dart SDK: https://dart.dev/get-dart
- Ensure `dart` is in your PATH

### Permission denied on Linux/macOS
- Make the build script executable: `chmod +x build.sh`
- Use `sudo` when copying to `/usr/local/bin/`

### Dependencies not found
- Run `dart pub get` before building
- Ensure `pubspec.yaml` is in the current directory

## Executable Size

Compiled executables are self-contained and include:
- The Dart runtime
- All dependencies (crypto package)
- Your compiled code

Typical size: ~10-15 MB depending on platform

## Performance

Compiled executables have:
- **Faster startup** compared to `dart main.dart`
- **Better performance** (AOT compilation)
- **No Dart SDK required** to run

## Distribution

To distribute Well.. Simple:

1. Build on each target platform
2. Package the executable with:
   - `README.md` - Language documentation
   - `docs/` - Complete documentation
   - `examples/` - Example programs
3. Create a release archive:
   ```bash
   # Linux
   tar -czf ws-linux-v1.0.tar.gz build/ws-linux README.md docs/ examples/
   
   # Windows
   zip -r ws-windows-v1.0.zip build\ws-windows.exe README.md docs\ examples\
   ```

## Version Information

To see the version in the compiled executable, the banner is displayed when run:
```
Well.. Simple v1.0
Type 'exit' to quit
>
```

## Clean Build

To clean and rebuild:

```bash
# Remove build directory
rm -rf build/

# Rebuild
./build.sh
```

## CI/CD Pipeline Example

For automated builds on multiple platforms:

```yaml
# .github/workflows/build.yml
name: Build

on: [push]

jobs:
  build-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: dart-lang/setup-dart@v1
      - run: dart pub get
      - run: ./build.sh
      - uses: actions/upload-artifact@v2
        with:
          name: ws-linux
          path: build/ws-linux

  build-macos:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - uses: dart-lang/setup-dart@v1
      - run: dart pub get
      - run: ./build.sh
      - uses: actions/upload-artifact@v2
        with:
          name: ws-macos
          path: build/ws-macos

  build-windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v2
      - uses: dart-lang/setup-dart@v1
      - run: dart pub get
      - run: build.bat
      - uses: actions/upload-artifact@v2
        with:
          name: ws-windows
          path: build/ws-windows.exe
```
