# GUI Library Documentation

The Well.. Simple GUI library provides a simple way to create visual graphical user interfaces that render in your web browser.

## Overview

The GUI library creates real, interactive windows that open in your default web browser. It uses HTML/CSS rendering to display your GUI layouts with proper styling and positioning. The window runs on a local HTTP server (port 8765) for instant visual feedback.

## Creating a Window

Use `gui.window()` to create a new window:

```
gui.window(800, 600, "My Application")
```

Parameters:
- `width`: Window width in pixels
- `height`: Window height in pixels
- `title`: Window title string

## Adding Widgets

### Button

Add a clickable button:

```
gui.button(50, 100, 200, 40, "Click Me")
```

Parameters:
- `x`: X position in pixels
- `y`: Y position in pixels
- `width`: Button width
- `height`: Button height
- `text`: Button label text

### Label

Add a text label:

```
gui.label(50, 50, "Welcome!")
```

Parameters:
- `x`: X position in pixels
- `y`: Y position in pixels
- `text`: Label text

### Input Field

Add a text input field:

```
gui.input(50, 150, 300, 30)
```

Parameters:
- `x`: X position in pixels
- `y`: Y position in pixels
- `width`: Input width
- `height`: Input height

## Showing and Closing

### Show Window

Display the window with all widgets:

```
gui.show()
```

This opens a real visual window in your default web browser, showing all your widgets with proper styling and positioning.

### Close Window

Close the window:

```
gui.close()
```

## Complete Example

```
# Create a login form
gui.window(400, 300, "Login")

# Add labels and inputs
gui.label(50, 50, "Username:")
gui.input(50, 80, 300, 30)

gui.label(50, 130, "Password:")
gui.input(50, 160, 300, 30)

# Add buttons
gui.button(50, 210, 100, 40, "Login")
gui.button(160, 210, 100, 40, "Cancel")

# Show the window
gui.show()

# Simulate some processing
sleep(3000)

# Close the window
gui.close()
```

## Widget Positioning

- Coordinates start at (0, 0) in the top-left corner
- X increases to the right
- Y increases downward
- All measurements are in pixels

## Best Practices

1. **Plan your layout**: Sketch your GUI on paper first
2. **Use consistent spacing**: Keep margins and gaps uniform
3. **Group related widgets**: Place related controls near each other
4. **Provide clear labels**: Make text descriptive and concise
5. **Test different sizes**: Try various widget dimensions

## Technical Details

- Renders using HTML5 and CSS3
- Runs on local HTTP server (port 8765)
- Opens in your default web browser
- Fallback to HTML file if server port is unavailable
- Cross-platform (Windows, macOS, Linux)
- Automatic cleanup when closed

## Current Limitations

- No event handlers for button clicks (yet)
- Cannot retrieve input values programmatically (yet)
- Widgets are static (display only)
- Single window at a time

## Future Enhancements

Planned features for future releases:
- Event handlers and callbacks
- Input value retrieval
- More widget types (checkbox, radio, dropdown, slider)
- Layout managers (grid, flexbox)
- Multi-window support
- Custom styling options
