# wpm - Well.. Simple Package Manager

**wpm** is the standalone package manager for Well.. Simple. It allows you to install, manage, and remove packages from Git repositories.

## Installation

### Building from Source

```bash
# Build wpm
dart compile exe wpm.dart -o wpm

# Or build all tools at once
./build-all.sh
```

### Install System-Wide

**Linux/macOS:**
```bash
sudo cp build/wpm-linux /usr/local/bin/wpm
sudo chmod +x /usr/local/bin/wpm
```

**Windows:**
1. Copy `build\wpm-windows.exe` to `C:\Program Files\WellSimple\wpm.exe`
2. Add directory to PATH

## Commands

### install - Install a Package

Install a package from a Git repository:

```bash
wpm install <git-url> [package-name]
```

**Examples:**
```bash
# Install with custom name
wpm install https://github.com/user/math-lib.git mathlib

# Auto-detect name from URL
wpm install https://github.com/user/string-utils.git

# Install from GitLab
wpm install https://gitlab.com/user/mylib.git

# Install from private repo (requires SSH keys)
wpm install git@github.com:user/private-lib.git
```

**Output:**
```
📦 Installing package: mathlib
🔗 From: https://github.com/user/math-lib.git
⬇️  Cloning repository...
✅ Package installed successfully!
📍 Location: ws_packages/mathlib
```

### list - List Installed Packages

Show all installed packages:

```bash
wpm list
# or
wpm ls
```

**Output:**
```
📦 Installed packages:
════════════════════════════════════════════════════════════

Package: mathlib
  URL:       https://github.com/user/math-lib.git
  Path:      ws_packages/mathlib
  Installed: 2025-11-29T10:30:00.000Z
  Version:   1.0.0

Package: stringutils
  URL:       https://github.com/user/string-utils.git
  Path:      ws_packages/stringutils
  Installed: 2025-11-29T11:45:00.000Z
  Version:   1.0.0

════════════════════════════════════════════════════════════
Total packages: 2
```

### remove - Uninstall a Package

Remove an installed package:

```bash
wpm remove <package-name>
# or
wpm rm <package-name>
wpm uninstall <package-name>
```

**Example:**
```bash
wpm remove mathlib
```

**Output:**
```
🗑️  Removed package directory: ws_packages/mathlib
✅ Package removed: mathlib
```

### update - Update a Package

Update a package to the latest version:

```bash
wpm update <package-name>
# or
wpm upgrade <package-name>
```

**Example:**
```bash
wpm update mathlib
```

**Output:**
```
🔄 Updating package: mathlib
✅ Package updated successfully!
```

### search - Search Packages

Search installed packages by name or URL:

```bash
wpm search <query>
# or
wpm find <query>
```

**Example:**
```bash
wpm search math
```

**Output:**
```
🔍 Search results for 'math':
════════════════════════════════════════════════════════════

Package: mathlib
  URL: https://github.com/user/math-lib.git

Package: advanced-math
  URL: https://github.com/user/advanced-math.git

════════════════════════════════════════════════════════════
Found 2 package(s)
```

### version - Show Version

Display wpm version:

```bash
wpm version
# or
wpm --version
wpm -v
```

**Output:**
```
wpm (Well.. Simple Package Manager) v1.0.0
Package manager for Well.. Simple programming language
```

### help - Show Help

Display help information:

```bash
wpm help
# or
wpm --help
wpm -h
```

## Package Structure

Packages are stored in:
- **Directory:** `ws_packages/`
- **Metadata:** `ws_packages.json`

Each package is a Git repository containing `.ws` files.

## Usage in Well.. Simple

After installing a package with wpm, use it in your programs:

```ws
# Import from installed package
import mathlib/functions.ws

# Use package functions
result = square(5)
print(result)
```

## Requirements

- **Git:** Must be installed and available in PATH
- **Internet:** Required for installing packages from remote repositories

### Verify Git Installation

```bash
git --version
```

## Common Workflows

### Install and Use a Package

```bash
# 1. Install package
wpm install https://github.com/user/mathlib.git

# 2. Use in program
echo 'import mathlib/main.ws' > test.ws
echo 'print("Package loaded!")' >> test.ws

# 3. Run program
ws test.ws
```

### Update All Packages

```bash
# List packages to see what's installed
wpm list

# Update each package
wpm update package1
wpm update package2
wpm update package3
```

### Clean Install

```bash
# Remove old version
wpm remove mypackage

# Install fresh
wpm install https://github.com/user/mypackage.git
```

## Troubleshooting

### "git: command not found"

Install Git:
```bash
# Ubuntu/Debian
sudo apt install git

# macOS
brew install git

# Windows
# Download from https://git-scm.com/
```

### "Error cloning repository"

- Verify the Git URL is correct
- Check internet connection
- For private repos, ensure SSH keys are configured
- Try cloning manually: `git clone <url>`

### "Package not found" when importing

- Run `wpm list` to verify package is installed
- Check the filename exists in the package
- Use correct path: `import package-name/file.ws`

### Permission Errors

```bash
# Linux/macOS
chmod -R u+w ws_packages/

# Or run wpm with sudo
sudo wpm install <url>
```

## Advanced Usage

### Private Repositories

Configure SSH keys for private repos:

```bash
# Generate SSH key
ssh-keygen -t rsa -b 4096

# Add to GitHub/GitLab
cat ~/.ssh/id_rsa.pub

# Install private package
wpm install git@github.com:user/private-repo.git
```

### Custom Package Names

```bash
# Use a friendly name instead of repo name
wpm install https://github.com/user/complicated-package-name-v2.git mylib
```

### Local Development

For local package development:

```bash
# Create symlink to development package
ln -s /path/to/dev/package ws_packages/devpackage

# It will appear in wpm list and be importable
```

## Package Metadata

The `ws_packages.json` file tracks installed packages:

```json
{
  "mathlib": {
    "url": "https://github.com/user/math-lib.git",
    "path": "ws_packages/mathlib",
    "installed": "2025-11-29T10:30:00.000Z",
    "version": "1.0.0"
  }
}
```

## Creating Packages

To create a package that others can install with wpm:

1. **Create Git repository:**
```bash
mkdir my-ws-package
cd my-ws-package
git init
```

2. **Add your .ws files:**
```ws
# utils.ws
def greet(name)
  print("Hello, " + name + "!")
end
```

3. **Add README:**
```markdown
# My WS Package

## Installation
\`\`\`bash
wpm install https://github.com/user/my-ws-package.git
\`\`\`

## Usage
\`\`\`ws
import my-ws-package/utils.ws
greet("World")
\`\`\`
```

4. **Commit and push:**
```bash
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/user/my-ws-package.git
git push -u origin main
```

5. **Share the URL!**

## Tips

- **Version names:** Consider using Git tags for versions
- **Documentation:** Include README.md in your packages
- **Examples:** Add example files to demonstrate usage
- **Testing:** Test packages before sharing
- **Updates:** Use `wpm update` to get latest changes

## Integration with wvm

wpm works alongside wvm (Well.. Simple Version Manager):

```bash
# Install a version of Well.. Simple
wvm install 1.0.0 /path/to/ws

# Use that version
wvm use 1.0.0

# Install packages (works with any version)
wpm install https://github.com/user/package.git

# Run program with current version
wvm run myprogram.ws
```

## See Also

- [wvm Documentation](wvm.md) - Version manager
- [Package Manager Guide](package-manager.md) - Creating packages
- [Well.. Simple Documentation](../README.md) - Language reference

---

**wpm v1.0.0** - Making package management simple! 📦
