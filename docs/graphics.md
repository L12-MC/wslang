# Graphics Engine

The REPL language includes a powerful graphics engine for drawing shapes on a canvas.

## Canvas Object

The canvas is a global object that you can use to draw various shapes.

### Canvas Properties

- **width**: 800 pixels (default)
- **height**: 600 pixels (default)

## Drawing Functions

### Clear Canvas

Remove all shapes from the canvas:

```repl
canvas.clear()
```

### Draw Circle

Draw a circle at position (x, y) with radius r:

```repl
canvas.drawCircle(x, y, radius, "color")
```

**Example:**
```repl
canvas.drawCircle(100, 100, 50, "red")
canvas.drawCircle(200, 150, 30, "blue")
canvas.drawCircle(300, 100, 40, "green")
```

### Draw Rectangle

Draw a rectangle at position (x, y) with width and height:

```repl
canvas.drawRectangle(x, y, width, height, "color")
```

**Example:**
```repl
canvas.drawRectangle(50, 50, 100, 80, "purple")
canvas.drawRectangle(200, 100, 150, 120, "orange")
```

### Draw Triangle

Draw a triangle with three vertices:

```repl
canvas.drawTriangle(x1, y1, x2, y2, x3, y3, "color")
```

**Example:**
```repl
canvas.drawTriangle(100, 50, 150, 150, 50, 150, "yellow")
canvas.drawTriangle(300, 100, 400, 100, 350, 50, "cyan")
```

### Draw Line

Draw a line from point (x1, y1) to (x2, y2):

```repl
canvas.drawLine(x1, y1, x2, y2, "color")
```

**Example:**
```repl
canvas.drawLine(0, 0, 100, 100, "black")
canvas.drawLine(100, 0, 0, 100, "red")
```

### Draw Polygon

Draw a polygon with multiple vertices:

```repl
canvas.drawPolygon([x1, y1, x2, y2, x3, y3, ...], "color")
```

**Example:**
```repl
# Pentagon
points = [100, 50, 150, 100, 120, 150, 80, 150, 50, 100]
canvas.drawPolygon(points, "magenta")

# Hexagon
canvas.drawPolygon([200, 100, 250, 120, 250, 160, 200, 180, 150, 160, 150, 120], "teal")
```

## Rendering

### Display Canvas

Show all drawn shapes in the console:

```repl
canvas.render()
```

Output:
```
=== Canvas Render (800x600) ===
Total shapes: 3
1. circle - color: red
2. rectangle - color: blue
3. triangle - color: green
=== End Render ===
```

### Export to SVG

Save the canvas as an SVG file:

```repl
canvas.exportSVG("output.svg")
```

This creates an SVG file that can be opened in any web browser or image editor.

## Color Names

Common color names you can use:
- **Basic**: `"red"`, `"blue"`, `"green"`, `"yellow"`, `"orange"`, `"purple"`
- **Extended**: `"cyan"`, `"magenta"`, `"pink"`, `"brown"`, `"gray"`, `"black"`, `"white"`
- **Hex colors**: `"#FF0000"` (red), `"#00FF00"` (green), `"#0000FF"` (blue)
- **RGB**: `"rgb(255, 0, 0)"` (red)

## Complete Example

Create a simple scene:

```repl
# Clear any previous drawings
canvas.clear()

# Draw sky
canvas.drawRectangle(0, 0, 800, 300, "lightblue")

# Draw ground
canvas.drawRectangle(0, 300, 800, 300, "green")

# Draw sun
canvas.drawCircle(700, 80, 40, "yellow")

# Draw house
canvas.drawRectangle(300, 350, 200, 150, "brown")

# Draw roof
canvas.drawTriangle(300, 350, 500, 350, 400, 250, "red")

# Draw door
canvas.drawRectangle(370, 420, 60, 80, "darkbrown")

# Draw windows
canvas.drawRectangle(330, 380, 40, 40, "lightblue")
canvas.drawRectangle(480, 380, 40, 40, "lightblue")

# Draw tree
canvas.drawRectangle(100, 400, 40, 100, "brown")
canvas.drawCircle(120, 380, 50, "darkgreen")

# Render to console
canvas.render()

# Export to file
canvas.exportSVG("scene.svg")
```

## Using Canvas in Functions

You can create reusable drawing functions:

```repl
def drawStar(x, y, size, color)
  # Draw a simple star shape
  canvas.drawPolygon([x, y-size, x+size/3, y-size/3, x+size, y-size/3, x+size/2, y+size/3, x+size*0.8, y+size, x, y+size/2, x-size*0.8, y+size, x-size/2, y+size/3, x-size, y-size/3, x-size/3, y-size/3], color)
end

drawStar(400, 300, 50, "gold")
canvas.render()
```

## Animation Concepts

While the canvas doesn't support real-time animation, you can create multiple frames:

```repl
# Frame 1
canvas.clear()
canvas.drawCircle(100, 300, 20, "red")
canvas.exportSVG("frame1.svg")

# Frame 2
canvas.clear()
canvas.drawCircle(200, 300, 20, "red")
canvas.exportSVG("frame2.svg")

# Frame 3
canvas.clear()
canvas.drawCircle(300, 300, 20, "red")
canvas.exportSVG("frame3.svg")
```

## Tips and Tricks

1. **Layer shapes**: Shapes are drawn in order, so later shapes appear on top
2. **Use variables**: Store positions and sizes in variables for easy adjustment
3. **Create templates**: Make .repl files with reusable drawing functions
4. **Export early**: Save your work with `exportSVG()` as you go
5. **Test rendering**: Use `render()` to check what's on the canvas before exporting
