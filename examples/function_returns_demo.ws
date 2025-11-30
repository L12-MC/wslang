# Comprehensive Function Returns Example

print("=== Well.. Simple v1.0.3 - Function Returns Demo ===")
print("")

# 1. Basic arithmetic functions
def add(a, b)
  return a + b
end

def subtract(a, b)
  return a - b
end

def multiply(a, b)
  return a * b
end

def divide(a, b)
  return a / b
end

print("1. Basic Arithmetic:")
print("add(10, 5) = ")
print(add(10, 5))
print("subtract(10, 5) = ")
print(subtract(10, 5))
print("multiply(10, 5) = ")
print(multiply(10, 5))
print("divide(10, 5) = ")
print(divide(10, 5))
print("")

# 2. Function composition
def square(x)
  return x * x
end

def cube(x)
  return x * x * x
end

print("2. Function Composition:")
print("square(5) = ")
print(square(5))
print("cube(3) = ")
print(cube(3))
print("square(3) + square(4) = ")
print(square(3) + square(4))
print("")

# 3. Conditional returns
def abs(x)
  if x < 0
    return 0 - x
  end
  return x
end

def max(a, b)
  if a > b
    return a
  end
  return b
end

def min(a, b)
  if a < b
    return a
  end
  return b
end

print("3. Conditional Returns:")
print("abs(-5) = ")
print(abs(0 - 5))
print("max(10, 20) = ")
print(max(10, 20))
print("min(10, 20) = ")
print(min(10, 20))
print("")

# 4. Complex expressions
def average(a, b)
  return divide(add(a, b), 2)
end

def sum_of_squares(a, b)
  return add(square(a), square(b))
end

print("4. Complex Expressions:")
print("average(10, 20) = ")
print(average(10, 20))
print("sum_of_squares(3, 4) = ")
print(sum_of_squares(3, 4))
print("")

# 5. Factorial with return
def factorial(n)
  if n <= 1
    return 1
  end
  result = 1
  i = 2
  while i <= n
    result = result * i
    i = i + 1
  end
  return result
end

print("5. Factorial Function:")
print("factorial(5) = ")
print(factorial(5))
print("factorial(6) = ")
print(factorial(6))
print("")

# 6. Using returns in calculations
a = 5
b = 3
c = 2

result = multiply(add(a, b), subtract(a, c))
print("6. Combined Calculation:")
print("(5 + 3) * (5 - 2) = ")
print(result)
print("")

print("=== All Examples Complete! ===")
