# Geometric shapes library

def drawStar(x, y, size, color)
  # 5-pointed star using polygon
  points = [x, y - size, x + size * 0.2, y - size * 0.2, x + size, y - size * 0.2, x + size * 0.3, y + size * 0.2, x + size * 0.5, y + size, x, y + size * 0.4, x - size * 0.5, y + size, x - size * 0.3, y + size * 0.2, x - size, y - size * 0.2, x - size * 0.2, y - size * 0.2]
  canvas.drawPolygon(points, color)
  print("Star drawn at " + x + ", " + y)
end

def drawHouse(x, y, size, color)
  # House body (rectangle)
  canvas.drawRectangle(x, y, size, size, color)
  
  # Roof (triangle)
  roofY = y - size * 0.5
  canvas.drawTriangle(x, y, x + size, y, x + size * 0.5, roofY, "red")
  
  # Door
  doorW = size * 0.3
  doorH = size * 0.5
  doorX = x + size * 0.35
  doorY = y + size * 0.5
  canvas.drawRectangle(doorX, doorY, doorW, doorH, "brown")
  
  print("House drawn at " + x + ", " + y)
end

def drawTree(x, y, size, color)
  # Trunk
  trunkW = size * 0.25
  trunkH = size * 0.5
  canvas.drawRectangle(x, y, trunkW, trunkH, "brown")
  
  # Leaves (circle)
  leafRadius = size * 0.4
  leafX = x + trunkW * 0.5
  leafY = y - leafRadius * 0.5
  canvas.drawCircle(leafX, leafY, leafRadius, color)
  
  print("Tree drawn at " + x + ", " + y)
end

def drawFlower(x, y, size, color)
  # Center
  canvas.drawCircle(x, y, size * 0.3, "yellow")
  
  # Petals
  offset = size * 0.5
  canvas.drawCircle(x, y - offset, size * 0.3, color)
  canvas.drawCircle(x + offset, y, size * 0.3, color)
  canvas.drawCircle(x, y + offset, size * 0.3, color)
  canvas.drawCircle(x - offset, y, size * 0.3, color)
  
  print("Flower drawn at " + x + ", " + y)
end

def drawCar(x, y, length, color)
  # Body
  canvas.drawRectangle(x, y, length, length * 0.4, color)
  
  # Cabin
  cabinW = length * 0.5
  cabinH = length * 0.3
  cabinX = x + length * 0.25
  cabinY = y - cabinH
  canvas.drawRectangle(cabinX, cabinY, cabinW, cabinH, color)
  
  # Wheels
  wheelRadius = length * 0.15
  wheelY = y + length * 0.4
  canvas.drawCircle(x + length * 0.25, wheelY, wheelRadius, "black")
  canvas.drawCircle(x + length * 0.75, wheelY, wheelRadius, "black")
  
  print("Car drawn at " + x + ", " + y)
end

print("Shapes library loaded")
print("Available: drawStar, drawHouse, drawTree, drawFlower, drawCar")
