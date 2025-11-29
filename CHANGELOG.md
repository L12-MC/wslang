# Well.. Simple - Version History

## v1.0.0 (Current)

**Release Date:** November 29, 2025

### Major Features

#### Package Manager
- **Git-based package manager** for installing and managing libraries
- `pkg.install(url, name)` - Install packages from Git repositories
- `pkg.list()` - List all installed packages
- `pkg.remove(name)` - Remove installed packages
- Automatic import path resolution from `ws_packages/` directory
- Package metadata tracking in `ws_packages.json`

#### Version Management
- **Version command** - Check current Well.. Simple version with `version`
- Semantic versioning: v1.0.0
- Version displayed in REPL banner and help

#### Cryptography Library
- **MD5 hashing** - `hash.md5(text)`
- **SHA256 hashing** - `hash.sha256(text)`
- **Base64 encoding** - `encode.base64(text)`
- **Base64 decoding** - `decode.base64(text)`

#### JSON Library
- **JSON stringify** - `json.stringify(obj)` - Convert data to JSON
- **JSON parse** - `json.parse(str)` - Parse JSON strings

#### File I/O
- **Write files** - `writeFile(path, content)`
- **Read files** - `readFile(path)`
- Support for relative and absolute paths

#### Error Handling
- **Try/Except/Finally** blocks for error handling
- Error variable available in except blocks
- Clean error recovery and cleanup

#### Language Rename
- Renamed from "REPL v0.3" to "Well.. Simple v1.0"
- New file extension: `.ws` (Well.. Simple)
- Backward compatibility with `.repl` files

#### Build System
- **Cross-platform build scripts** - `build.sh` (Linux/macOS), `build.bat` (Windows)
- **Standalone executables** - Compile to native binaries
- Platform detection and automatic configuration

### Improvements

- **Import path resolution** - Automatic searching in packages directory
- **Clean output** - Removed verbose logging
- **Enhanced help** - Updated help command with all new features
- **Better documentation** - Comprehensive docs for all features

### Documentation

New documentation files:
- `docs/package-manager.md` - Complete package manager guide
- `docs/building.md` - Build and distribution guide
- `docs/error-handling.md` - Error handling patterns
- `docs/file-io.md` - File operations guide
- `docs/json.md` - JSON manipulation
- `docs/cryptography.md` - Cryptography functions

### Example Programs

- `examples/features.ws` - Demo of all v1.0 features
- `examples/package-demo.ws` - Package manager usage
- `examples/test-pkg-manager.ws` - Package manager testing
- `example-package/` - Sample package structure

### Technical Details

- **Dart SDK**: 3.0+ required
- **Dependencies**: `crypto` package ^3.0.3
- **Package storage**: `ws_packages/` directory
- **Metadata file**: `ws_packages.json`

---

## v0.3 (Previous - REPL)

**Release Date:** (Earlier version)

### Features

- **Graphics Engine** - Canvas drawing with SVG export
  - `canvas.drawCircle()`, `canvas.drawRectangle()`, `canvas.drawTriangle()`
  - `canvas.drawLine()`, `canvas.drawPolygon()`
  - `canvas.exportSVG()` for saving drawings

- **Core Language**
  - Variables and data types
  - String operations and concatenation
  - Lists with indexing and operations
  - Control flow: if/else, while, for loops
  - Functions: User-defined functions with parameters
  - File execution: Import and run `.repl` files

- **Built-in Functions**
  - `print()`, `concat()`, `split()`
  - `append()`, `length()`
  - `range()` for loops

---

## Upgrade Path

### From v0.3 to v1.0

1. **Files**: Rename `.repl` files to `.ws` (optional, both work)
2. **Features**: Start using new features:
   - Add error handling with try/except
   - Use JSON for data serialization
   - Add cryptography for security
   - Install packages for reusable code
3. **Build**: Compile to standalone executables
4. **Documentation**: Review new docs for best practices

### Breaking Changes

**None** - v1.0 is fully backward compatible with v0.3

---

## Future Roadmap

### v1.1 (Planned)

- Package versioning and dependency resolution
- Package registry/index
- Update checking for packages
- Improved error messages
- More built-in functions
- HTTP/HTTPS library
- Database connectivity

### v2.0 (Future)

- Standard library modules
- Class inheritance
- Modules and namespaces
- Debugger support
- Performance optimizations
- Plugin system

---

## Contributing

To contribute to Well.. Simple:

1. **Report bugs** - Open issues for bugs or feature requests
2. **Create packages** - Build and share useful libraries
3. **Improve docs** - Help improve documentation
4. **Submit PRs** - Contribute code improvements

---

## License

Open source and free to use.

---

## Credits

**Well.. Simple** - Making programming simple!

For more information:
- [README.md](../README.md)
- [Documentation](.)
- [Package Manager](package-manager.md)

---

**Version**: 1.0.0  
**Released**: November 29, 2025  
**Status**: Stable
