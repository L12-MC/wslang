# Package Manager

Well.. Simple includes a built-in package manager that uses Git to install and manage libraries from remote repositories.

## Overview

The package manager allows you to:
- Install packages from any Git repository
- List installed packages
- Remove packages
- Import code from installed packages automatically

All packages are stored in the `ws_packages/` directory.

## Commands

### Installing Packages

Install a package from a Git repository:

```ws
pkg.install("https://github.com/username/package-name.git", "package-name")
```

Or let the system auto-detect the package name:

```ws
pkg.install("https://github.com/username/mylib.git")
```

**Example:**
```ws
>> pkg.install("https://github.com/myuser/mathlib.git", "mathlib")
Installing package: mathlib
From: https://github.com/myuser/mathlib.git
Cloning repository...
Package installed successfully!
```

### Listing Packages

View all installed packages:

```ws
pkg.list()
```

**Example output:**
```
Installed packages:
==================

mathlib
  URL: https://github.com/myuser/mathlib.git
  Path: ws_packages/mathlib
  Installed: 2024-01-15T10:30:00.000

utils
  URL: https://github.com/other/utils.git
  Path: ws_packages/utils
  Installed: 2024-01-15T11:45:00.000
```

### Removing Packages

Uninstall a package:

```ws
pkg.remove("package-name")
```

**Example:**
```ws
>> pkg.remove("mathlib")
Package removed: mathlib
```

### Checking Version

Display the current Well.. Simple version:

```ws
version
```

## Using Installed Packages

Once a package is installed, you can import files from it using the `import` or `run` commands. The system will automatically search in the `ws_packages/` directory.

### Import Example

```ws
# Install a package
pkg.install("https://github.com/myuser/mathlib.git", "mathlib")

# Import a file from the package
import mathlib/functions.ws

# Or just
import functions.ws  # Will find it in mathlib package

# Use the imported functions
result = square(5)
print(result)
```

## Package Structure

### Creating a Package

A Well.. Simple package is simply a Git repository containing `.ws` files:

```
my-package/
├── README.md
├── main.ws
├── utils.ws
└── helpers.ws
```

### Package Best Practices

1. **README.md** - Document your package
2. **main.ws** - Entry point (optional)
3. **Organize by feature** - Split code into logical files
4. **Use meaningful names** - Clear file and function names
5. **Add examples** - Include example usage

### Example Package File

**mypackage/math.ws:**
```ws
# Math utility functions

def square(x)
  result = x * x
end

def cube(x)
  result = x * x * x
end

def factorial(n)
  if n <= 1
    result = 1
  else
    result = n * factorial(n - 1)
  end
end

print("Math library loaded")
```

## Package Metadata

Installed packages are tracked in `ws_packages.json`:

```json
{
  "mathlib": {
    "url": "https://github.com/myuser/mathlib.git",
    "path": "ws_packages/mathlib",
    "installed": "2024-01-15T10:30:00.000"
  }
}
```

## Requirements

### Git Installation

The package manager requires Git to be installed on your system:

**Linux:**
```bash
sudo apt install git  # Ubuntu/Debian
sudo dnf install git  # Fedora
sudo pacman -S git    # Arch
```

**macOS:**
```bash
brew install git
```

**Windows:**
Download from [git-scm.com](https://git-scm.com/)

### Verify Git Installation

```bash
git --version
```

## Common Workflows

### Installing and Using a Library

```ws
# 1. Install the package
pkg.install("https://github.com/example/stringutils.git", "stringutils")

# 2. Import functions from the package
import stringutils/helpers.ws

# 3. Use the functions
cleaned = trim("  hello  ")
print(cleaned)
```

### Creating Your Own Package

1. **Create a Git repository:**
```bash
mkdir my-ws-library
cd my-ws-library
git init
```

2. **Add your .ws files:**
```ws
# utils.ws
def greet(name)
  print("Hello, " + name + "!")
end

def farewell(name)
  print("Goodbye, " + name + "!")
end
```

3. **Commit and push:**
```bash
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/my-ws-library.git
git push -u origin main
```

4. **Install in any project:**
```ws
pkg.install("https://github.com/yourusername/my-ws-library.git", "mylib")
import mylib/utils.ws
greet("World")
```

### Updating a Package

To update a package to the latest version:

```ws
# Remove the old version
pkg.remove("mypackage")

# Install the latest version
pkg.install("https://github.com/user/mypackage.git", "mypackage")
```

### Using Multiple Packages

```ws
# Install multiple packages
pkg.install("https://github.com/user/math.git", "math")
pkg.install("https://github.com/user/strings.git", "strings")
pkg.install("https://github.com/user/data.git", "data")

# List all installed
pkg.list()

# Use them in your code
import math/advanced.ws
import strings/parser.ws
import data/csv.ws
```

## Package Discovery

### Finding Packages

Look for Well.. Simple packages on:
- GitHub (search for "well-simple" or "ws-package")
- Package repositories
- Community forums

### Sharing Packages

To share your package:
1. Host it on GitHub/GitLab/Bitbucket
2. Add a README with installation instructions
3. Share the Git URL with others

## Advanced Usage

### Private Repositories

For private Git repositories, ensure you have SSH keys or credentials configured:

```ws
# Use SSH URL
pkg.install("git@github.com:username/private-repo.git", "private")

# Git will use your configured credentials
```

### Specific Branches

To install from a specific branch, clone manually:

```bash
cd ws_packages
git clone -b develop https://github.com/user/package.git mypackage
```

Then it will be available in Well.. Simple:
```ws
import mypackage/main.ws
```

### Local Development

For local package development, you can create a symlink:

```bash
ln -s /path/to/your/dev/package ws_packages/devpackage
```

## Troubleshooting

### "git: command not found"

Install Git on your system (see Requirements section above).

### "Error cloning repository"

- Check the Git URL is correct
- Verify you have internet access
- For private repos, ensure credentials are configured
- Try cloning manually with `git clone <url>`

### "Package not found" on import

- Run `pkg.list()` to verify the package is installed
- Check the filename exists in the package directory
- Use the correct path: `import package/file.ws`

### Permission Errors

On Linux/macOS, you may need write permissions:
```bash
chmod -R u+w ws_packages/
```

## Package Manager Files

The package manager creates these files/directories:

- `ws_packages/` - Directory containing all installed packages
- `ws_packages.json` - Metadata file tracking installations

**Note:** Add these to `.gitignore` if committing your project:
```
ws_packages/
ws_packages.json
```

## Security Considerations

- **Trust sources** - Only install packages from trusted sources
- **Review code** - Check package code before using in production
- **Update regularly** - Keep packages up to date
- **Sandboxing** - Well.. Simple has no built-in sandboxing, packages have full file system access

## Example: Complete Project

**myproject.ws:**
```ws
# Import external libraries
import math/advanced.ws
import strings/utils.ws

# Use library functions
x = sqrt(16)
y = capitalize("hello world")

print(x)
print(y)

# Your project code
def main()
  print("My project using packages!")
end

main()
```

**Install dependencies:**
```ws
pkg.install("https://github.com/wslibs/math.git", "math")
pkg.install("https://github.com/wslibs/strings.git", "strings")
```

**Run:**
```bash
dart main.dart myproject.ws
# Or with compiled executable
./ws-linux myproject.ws
```

## Future Enhancements

Planned features for the package manager:

- Package versioning (semver)
- Dependency resolution
- Package registry/index
- Package update checking
- Lock file for reproducible installs
- Package templates
- Publishing tools

## Contributing Packages

To contribute to the Well.. Simple ecosystem:

1. Create useful, well-documented packages
2. Follow naming conventions (ws-packagename)
3. Include examples and tests
4. Share on GitHub with the `well-simple` topic
5. Announce in the community

---

**Happy package managing!** 📦

For more information, see:
- [Getting Started](getting-started.md)
- [Functions](functions.md)
- [File I/O](file-io.md)
