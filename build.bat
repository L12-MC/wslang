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
dart compile exe main.dart --target-os linux -o build\ws-linux

if %errorlevel% equ 0 (
    echo.
    echo ==============================
    echo + Build successful!
) else (
    echo.
    echo X Build failed
    exit /b 1
)
