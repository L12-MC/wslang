# Well.. Simple v1.0 - Feature Showcase
# This demonstrates the new input() and error handling features

print("╔════════════════════════════════════════╗")
print("║  Well.. Simple v1.0 Feature Showcase   ║")
print("╚════════════════════════════════════════╝")
print("")

# Feature 1: User Input
print("✓ Feature 1: User Input")
print("-------------------------")
name = input("Enter your name: ")
print("Welcome, ")
print(name)
print("")

# Feature 2: Variables and Math
print("✓ Feature 2: Variables & Math")
print("-------------------------")
x = 10
y = 5
sum = x + y
diff = x - y
prod = x * y
quot = x / y

print("x = 10, y = 5")
print("Sum: ")
print(sum)
print("Difference: ")
print(diff)
print("Product: ")
print(prod)
print("Quotient: ")
print(quot)
print("")

# Feature 3: Lists
print("✓ Feature 3: Lists")
print("-------------------------")
numbers = [10, 20, 30, 40, 50]
first = numbers[0]
last = numbers[4]

print("List: [10, 20, 30, 40, 50]")
print("First element: ")
print(first)
print("Last element: ")
print(last)
print("")

# Feature 4: Error Handling with try-except
print("✓ Feature 4: Error Handling")
print("-------------------------")

# Safe division
try
  print("Attempting safe division: 100 / 10")
  safe_result = 100 / 10
  print("Result: ")
  print(safe_result)
except
  print("Error occurred!")
finally
  print("Division complete")
end

print("")

# Handle potential errors
try
  print("Attempting risky division: 100 / 0")
  risky_result = 100 / 0
  print("This won't print")
except
  print("Successfully caught the error!")
finally
  print("Error handling complete")
end

print("")

# Feature 5: Enhanced Error Messages
print("✓ Feature 5: Error Messages")
print("-------------------------")
print("Errors now show:")
print("  ✓ File name")
print("  ✓ Line number")
print("  ✓ Code snippet")
print("  ✓ Helpful suggestions")
print("")

print("╔════════════════════════════════════════╗")
print("║      All Features Working Great!       ║")
print("╚════════════════════════════════════════╝")
