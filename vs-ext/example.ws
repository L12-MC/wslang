# Well.. Simple Example File
# This demonstrates syntax highlighting

# Function definition
def greet(name)
  print("Hello, " + name + "!")
  return true
end

# Variables and compound assignments
counter = 0
counter += 10
counter -= 5

# String methods (v1.0.3)
text = "Programming"
len = text.length()
first_char = text.letter(0)

print("Text: " + text)
print("Length: ")
print(len)
print("First character: " + first_char)

# Control flow with break
for i in range(0, 10)
  print(i)
  
  if i == 5
    print("Breaking at 5!")
    break
  end
end

# While loop
x = 0
while x < 5
  print(x)
  x += 1
end

# Conditionals
if counter > 0
  print("Counter is positive")
else
  print("Counter is not positive")
end

# Try/except
try
  result = 10 / 2
  print(result)
except
  print("An error occurred")
finally
  print("Cleanup complete")
end

# Class definition
class Person
  def init(name, age)
    this.name = name
    this.age = age
  end
  
  def info()
    print("Name: " + this.name)
    print("Age: ")
    print(this.age)
  end
end

# Boolean values
is_valid = true
is_done = false

# Logical operators
if is_valid and not is_done
  print("Valid but not done")
end

# Comparison operators
if counter == 5
  print("Counter is 5")
end

if counter >= 5
  print("Counter is 5 or more")
end

# Built-in functions
version()
input("Enter your name: ")

# Package manager
# pkg.install("https://github.com/example/package")
# pkg.list()

# String operations
message = "Hello"
upper_message = message.upper()
