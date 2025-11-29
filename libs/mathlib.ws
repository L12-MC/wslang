# Math utility library

def square(x)
  result = x * x
  print(result)
end

def cube(x)
  result = x * x * x
  print(result)
end

def add(a, b)
  result = a + b
  print(result)
end

def multiply(a, b)
  result = a * b
  print(result)
end

def factorial(n)
  result = 1
  for i in range(1, n + 1)
    result = result * i
  end
  print(result)
end

def power(base, exp)
  result = 1
  for i in range(0, exp)
    result = result * base
  end
  print(result)
end

# Constants
pi = 3.14159
e = 2.71828

print("Math library loaded")
