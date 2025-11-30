version()

print("=== Class Features Test ===")

class Circle
radius = 0
pi = 3.14159
def init(r)
this.radius = r
end
def area()
result = this.pi * this.radius * this.radius
print(result)
end
def circumference()
result = 2 * this.pi * this.radius
print(result)
end
end

circle = new Circle(5)
print("Circle with radius 5:")
circle.area()
circle.circumference()

print("")
print("=== File I/O Test ===")
fileContent = readFile("test_input.txt")
print("File contains:")
print(fileContent)

print("")
print("=== Package Import Test ===")
import testpkg/powers.wsx
print("Square of 7:")
square(7)

print("")
print("=== Success! All features working ===")
