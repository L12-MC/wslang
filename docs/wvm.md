# wvm - Well.. Simple Version Manager

**wvm** is the version manager for Well.. Simple. It allows you to install and manage multiple versions of Well.. Simple side-by-side, and easily switch between them.

## Installation

### Building from Source

```bash
# Build wvm
dart compile exe wvm.dart -o wvm

# Or build all tools at once
./build-all.sh
```

### Install System-Wide

**Linux/macOS:**
```bash
sudo cp build/wvm-linux /usr/local/bin/wvm
sudo chmod +x /usr/local/bin/wvm
```

**Windows:**
1. Copy `build\wvm-windows.exe` to `C:\Program Files\WellSimple\wvm.exe`
2. Add directory to PATH

## Commands

### install - Install a Version

Register a Well.. Simple executable with wvm:

```bash
wvm install <version-name> <path-to-executable>
```

**Examples:**
```bash
# Install version 1.0.0
wvm install 1.0.0 /path/to/ws-linux

# Install development version
wvm install dev ./build/ws-linux

# Install stable release
wvm install stable /usr/local/bin/ws
```

**Output:**
```
✅ Set as current version
✅ Version 1.0.0 installed successfully!
📍 Path: /path/to/ws-linux

To use this version, run:
  wvm use 1.0.0
```

### list - List Installed Versions

Show all installed versions:

```bash
wvm list
# or
wvm ls
```

**Output:**
```
📦 Installed Well.. Simple versions:
════════════════════════════════════════════════════════════

→ 1.0.0 (current)
    Path:      /home/user/ws/build/ws-linux
    Installed: 2025-11-29T10:30:00.000Z

  1.1.0
    Path:      /home/user/ws-1.1/build/ws-linux
    Installed: 2025-11-29T12:00:00.000Z

  dev
    Path:      /home/user/ws-dev/build/ws-linux
    Installed: 2025-11-29T14:30:00.000Z

════════════════════════════════════════════════════════════
Total versions: 3
Current version: 1.0.0
```

### use - Switch Version

Set the current version to use:

```bash
wvm use <version-name>
```

**Examples:**
```bash
# Switch to version 1.0.0
wvm use 1.0.0

# Switch to development version
wvm use dev

# Switch to stable
wvm use stable
```

**Output:**
```
✅ Switched to version 1.0.0
📍 Path: /home/user/ws/build/ws-linux

To run Well.. Simple:
  wvm run [program.ws]
```

### remove - Remove a Version

Unregister a version from wvm:

```bash
wvm remove <version-name>
# or
wvm rm <version-name>
wvm uninstall <version-name>
```

**Example:**
```bash
wvm remove dev
```

**Output:**
```
✅ Version dev removed
```

**Note:** This only removes the version from wvm's registry. The actual executable file is not deleted.

### current - Show Current Version

Display the currently active version:

```bash
wvm current
```

**Output:**
```
Current version: 1.0.0
Path: /home/user/ws/build/ws-linux
Installed: 2025-11-29T10:30:00.000Z
```

### which - Show Version Path

Display the path to the current version's executable:

```bash
wvm which
```

**Output:**
```
/home/user/ws/build/ws-linux
```

This is useful for scripting:
```bash
# Get the path and use it
WS_PATH=$(wvm which)
$WS_PATH myprogram.ws
```

### run - Run with Current Version

Execute Well.. Simple programs using the current version:

```bash
wvm run [program.ws]
```

**Examples:**
```bash
# Run interactive mode
wvm run

# Run a program
wvm run myprogram.ws

# Pass arguments
wvm run myprogram.ws arg1 arg2
```

**Output:**
```
🚀 Running Well.. Simple 1.0.0
   /home/user/ws/build/ws-linux myprogram.ws

Well.. Simple v1.0.0
Type 'help' for available commands, 'exit()' to quit
>> 
```

### version - Show wvm Version

Display wvm version:

```bash
wvm version
# or
wvm --version
wvm -v
```

**Output:**
```
wvm (Well.. Simple Version Manager) v1.0.0
Version manager for Well.. Simple programming language
```

### help - Show Help

Display help information:

```bash
wvm help
# or
wvm --help
wvm -h
```

## Version Management Structure

Versions are tracked in:
- **Directory:** `.wvm/`
- **Config file:** `.wvm/config.json`

Example `.wvm/config.json`:
```json
{
  "current_version": "1.0.0",
  "versions": {
    "1.0.0": {
      "path": "/home/user/ws/build/ws-linux",
      "installed": "2025-11-29T10:30:00.000Z"
    },
    "dev": {
      "path": "/home/user/ws-dev/build/ws-linux",
      "installed": "2025-11-29T14:30:00.000Z"
    }
  },
  "default_path": null
}
```

## Common Workflows

### Install and Use Multiple Versions

```bash
# Build different versions
cd ~/ws-1.0.0
./build.sh

cd ~/ws-1.1.0
./build.sh

# Install both versions
wvm install 1.0.0 ~/ws-1.0.0/build/ws-linux
wvm install 1.1.0 ~/ws-1.1.0/build/ws-linux

# List versions
wvm list

# Switch between versions
wvm use 1.0.0
wvm run test.ws

wvm use 1.1.0
wvm run test.ws
```

### Development Workflow

```bash
# Install stable version for production
wvm install stable /usr/local/bin/ws

# Install development version for testing
wvm install dev ./build/ws-linux

# Work with dev version
wvm use dev
wvm run test-new-features.ws

# Switch to stable for production
wvm use stable
wvm run production.ws
```

### Testing Across Versions

```bash
# Test program with multiple versions
for version in 1.0.0 1.1.0 2.0.0; do
    echo "Testing with version $version"
    wvm use $version
    wvm run tests.ws
done
```

### CI/CD Integration

```bash
#!/bin/bash
# ci-test.sh

# Install specific version for CI
wvm install ci-test ./build/ws-linux
wvm use ci-test

# Run tests
wvm run tests.ws

# Exit with test result
exit $?
```

## Version Naming

Version names can be anything you like:

- **Semantic versions:** `1.0.0`, `1.1.0`, `2.0.0`
- **Named releases:** `stable`, `beta`, `alpha`
- **Development:** `dev`, `nightly`, `experimental`
- **Custom:** `my-custom-build`, `feature-xyz`

## Troubleshooting

### "No version set as current"

You need to install and set a version:

```bash
wvm install 1.0.0 /path/to/ws
wvm use 1.0.0
```

### "Version not found"

Check installed versions:

```bash
wvm list
```

Install the version you need:

```bash
wvm install <version> <path>
```

### "File not found" during install

Verify the executable path is correct:

```bash
ls -la /path/to/ws-linux

# Use absolute paths
wvm install 1.0.0 $(pwd)/build/ws-linux
```

### Permission Issues

Ensure the executable has execute permissions:

```bash
chmod +x /path/to/ws-linux
wvm install 1.0.0 /path/to/ws-linux
```

## Advanced Usage

### Multiple Development Branches

```bash
# Main branch
git checkout main
./build.sh
wvm install main ./build/ws-linux

# Feature branch
git checkout feature-xyz
./build.sh
wvm install feature-xyz ./build/ws-linux

# Compare behavior
wvm use main
wvm run test.ws

wvm use feature-xyz
wvm run test.ws
```

### Platform-Specific Versions

```bash
# Linux build
wvm install 1.0.0-linux ./build/ws-linux

# macOS build (if on macOS)
wvm install 1.0.0-macos ./build/ws-macos

# Windows build (if on Windows)
wvm install 1.0.0-windows ./build/ws-windows.exe
```

### Automated Version Detection

```bash
#!/bin/bash
# auto-version.sh

VERSION=$(./build/ws-linux --version 2>/dev/null | grep -oP 'v\K[0-9.]+' || echo "unknown")
wvm install $VERSION ./build/ws-linux
wvm use $VERSION
```

## Integration with wpm

wvm and wpm work together:

```bash
# Install and use a specific version
wvm install 1.0.0 /path/to/ws-linux
wvm use 1.0.0

# Install packages (work with any version)
wpm install https://github.com/user/package.git

# Run program with current version
wvm run myprogram.ws
```

## Shell Integration

### Bash/Zsh Alias

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Quick version switching
alias ws='wvm run'

# Version shortcuts
alias ws-dev='wvm use dev && wvm run'
alias ws-stable='wvm use stable && wvm run'
```

Usage:
```bash
# Run with default version
ws myprogram.ws

# Run with dev version
ws-dev myprogram.ws

# Run with stable version
ws-stable myprogram.ws
```

### Fish Shell

Add to `~/.config/fish/config.fish`:

```fish
# Quick version switching
alias ws='wvm run'

function ws-use
    wvm use $argv[1]
    wvm run $argv[2..-1]
end
```

## Best Practices

1. **Semantic Naming:** Use clear version names (1.0.0, 1.1.0)
2. **Current Version:** Always have a current version set
3. **Documentation:** Document which version is used for each project
4. **Testing:** Test programs with multiple versions
5. **Cleanup:** Remove old versions you no longer need

## Tips

- **List before using:** Run `wvm list` to see available versions
- **Absolute paths:** Use absolute paths when installing
- **Shell integration:** Create aliases for common workflows
- **CI/CD:** Use wvm in automated testing
- **Version tags:** Match wvm versions to Git tags

## Comparison with Other Version Managers

wvm is inspired by:
- **nvm** (Node Version Manager)
- **rvm** (Ruby Version Manager)
- **pyenv** (Python Version Manager)

But designed specifically for Well.. Simple!

## See Also

- [wpm Documentation](wpm.md) - Package manager
- [Building Well.. Simple](building.md) - Build executables
- [Well.. Simple Documentation](../README.md) - Language reference

---

**wvm v1.0.0** - Making version management simple! 🔄
