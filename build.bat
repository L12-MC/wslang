@echo off
REM Build script for Well.. Simple interpreter (Windows)
REM Compiles for Windows platform

echo Building Well.. Simple v1.0
echo ==============================
echo.

REM Create build directory
if not exist build mkdir build

echo Detected platform: Windows
echo.

REM Build for Windows
echo Building executable...
dart compile exe main.dart -o build\ws-windows.exe

if %errorlevel% equ 0 (
    echo.
    echo ==============================
    echo + Build successful!
    echo.
    echo Executable: build\ws-windows.exe
    echo.
    echo To run:
    echo   Interactive mode: build\ws-windows.exe
    echo   Run a file:       build\ws-windows.exe program.ws
    echo.
    echo Note: Cross-compilation requires building on each platform.
    echo Run build.sh on Linux/macOS to build for those platforms.
) else (
    echo.
    echo X Build failed
    exit /b 1
)
