@echo off
REM Well.. Simple VS Code Extension Setup Script

echo ==================================
echo Well.. Simple VS Code Extension
echo ==================================
echo.

REM Check if we're in the vs-ext directory
if not exist "package.json" (
    echo Error: Please run this script from the vs-ext directory
    exit /b 1
)

echo.
echo Step 1: Checking for vsce (VS Code Extension Manager)...
where vsce >nul 2>&1
if %errorlevel% equ 0 (
    echo [32m√[0m vsce is installed
    
    echo.
    echo Step 2: Packaging extension...
    call vsce package --no-yarn
    
    if %errorlevel% equ 0 (
        echo [32m√[0m Extension packaged successfully!
        echo.
        echo Installation options:
        echo   1. Install via VS Code:
        echo      - Open VS Code
        echo      - Press Ctrl+Shift+P
        echo      - Type 'Install from VSIX'
        echo      - Select the .vsix file in this directory
        echo.
        echo   2. Manual installation:
        echo      - Copy this directory to:
        echo        Windows: %%USERPROFILE%%\.vscode\extensions\wslang-1.1.0
        echo.
    ) else (
        echo [31m×[0m Failed to package extension
        exit /b 1
    )
) else (
    echo [33m![0m vsce not found. Install it with: npm install -g @vscode/vsce
    echo.
    echo Alternative: Manual installation
    echo   Copy this directory to:
    echo     Windows: %%USERPROFILE%%\.vscode\extensions\wslang-1.1.0
)

echo.
echo Step 3: Testing
echo   - Open example.ws in VS Code to test syntax highlighting
echo   - Type 'gui.' to test autocomplete
echo   - Create syntax errors to test error detection
echo.
echo Done!
pause
