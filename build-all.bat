@echo off
REM Build script for Well.. Simple tools (Windows)
REM Compiles ws, wpm, and wvm

echo Building Well.. Simple Tools v1.0
echo ======================================
echo.

REM Create build directory
if not exist build mkdir build

echo Detected platform: Windows
echo.

REM Build Well.. Simple interpreter
echo Building Well.. Simple interpreter...
dart compile exe main.dart -o build\ws-windows.exe
if %errorlevel% equ 0 (
    echo + ws compiled: build\ws-windows.exe
) else (
    echo X ws compilation failed
    exit /b 1
)
echo.

REM Build wpm (Package Manager)
echo Building wpm (Package Manager)...
dart compile exe wpm.dart -o build\wpm-windows.exe
if %errorlevel% equ 0 (
    echo + wpm compiled: build\wpm-windows.exe
) else (
    echo X wpm compilation failed
    exit /b 1
)
echo.

REM Build wvm (Version Manager)
echo Building wvm (Version Manager)...
dart compile exe wvm.dart -o build\wvm-windows.exe
if %errorlevel% equ 0 (
    echo + wvm compiled: build\wvm-windows.exe
) else (
    echo X wvm compilation failed
    exit /b 1
)
echo.

echo ======================================
echo + Build successful!
echo.
echo Executables in build\ directory:
echo   - build\ws-windows.exe  (Well.. Simple interpreter)
echo   - build\wpm-windows.exe (Package manager)
echo   - build\wvm-windows.exe (Version manager)
echo.
echo To install system-wide:
echo   1. Copy executables to C:\Program Files\WellSimple\
echo   2. Add directory to PATH
echo   3. Optionally rename to ws.exe, wpm.exe, wvm.exe
echo.
echo Usage:
echo   ws program.ws           # Run Well.. Simple programs
echo   wpm install URL         # Install packages
echo   wvm install 1.0.0 path  # Manage versions
