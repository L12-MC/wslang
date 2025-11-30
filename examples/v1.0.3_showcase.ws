# Showcase all v1.0.3 features together
# Simple string processing with early exit

print("=== String Feature Showcase ===")
print("")

# Test string methods
text1 = "Hello"
text2 = "World"

print("Testing string.length():")
len1 = text1.length()
len2 = text2.length()
print(len1)
print(len2)
print("")

print("Testing string.letter(index):")
print(text1.letter(0))
print(text1.letter(4))
print(text2.letter(0))
print(text2.letter(4))
print("")

# Test compound assignments
print("Testing += and -= operators:")
counter = 0
print("Starting counter: 0")

counter += 10
print("After += 10:")
print(counter)

counter += 5
print("After += 5:")
print(counter)

counter -= 3
print("After -= 3:")
print(counter)
print("")

# Test break statement
print("Testing break in loop:")
for i in range(0, 10)
  print(i)
  if i == 4
    print("Breaking at 4!")
    break
  end
end
print("")

# Combined example
print("=== Combined Example ===")
word = "Programming"
total = 0
word_len = word.length()

print("Processing word: Programming")
for i in range(0, 11)
  letter = word.letter(i)
  print(letter)
  total += 1
  
  # Stop at first 'g'
  if letter == "g"
    print("Found 'g'! Processed letters:")
    print(total)
    break
  end
end

print("")
print("=== Demo Complete ===")
