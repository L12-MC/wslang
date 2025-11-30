# Well.. Simple v1.0.3 Release Notes

## New Features

### 1. Compound Assignment Operators (`+=` and `-=`)

You can now use `+=` and `-=` operators to modify numeric variables more concisely:

```
x = 10
x += 5    # x is now 15
x -= 3    # x is now 12
```

**Previous syntax:**
```
x = x + 5
x = x - 3
```

**Benefits:**
- More concise and readable code
- Clearer intent when incrementing/decrementing
- Matches syntax from other popular languages

### 2. Break Statement

The `break` keyword allows you to exit loops early:

```
# Exit while loop
i = 1
while i <= 10
  print(i)
  if i == 5
    break
  end
  i += 1
end

# Exit for loop
for j in range(0, 100)
  print(j)
  if j == 10
    break
  end
end
```

**Use cases:**
- Search operations (stop when found)
- Conditional early termination
- Error handling in loops

### 3. String Methods

Two new string methods for working with text:

#### `.length()` - Get string length
```
text = "Hello"
print(text.length())    # Output: 5

# Can also use directly
print("World".length())  # Output: 5

# Store in variable
len = text.length()
```

#### `.letter(index)` - Get character at position
```
text = "Hello"
print(text.letter(0))   # Output: H
print(text.letter(1))   # Output: e
print(text.letter(4))   # Output: o

# Can also use directly
print("World".letter(2))  # Output: r

# Store in variable
char = text.letter(3)
```

**Note:** Indexing is 0-based (first character is at index 0)

### 4. Cleaner Output

Removed verbose logging messages for a cleaner execution experience:

**Removed:**
- `> Function funcname defined`
- `> Executing filepath.ws`
- `> Finished executing filepath.ws`

**Result:** Only your program's output is displayed, making it easier to read and parse.

## Examples

### Complete Example

```
# Compound assignment with loops and strings
count = 0
text = "Programming"

print("Counting letters until we find 'g':")
for i in range(0, text.length())
  letter = text.letter(i)
  print(letter)
  count += 1
  
  if letter == "g"
    break
  end
end

print("Found after checking " + count + " letters")
```

## Compatibility

All new features are backwards compatible. Existing scripts will continue to work without modification.

## Upgrade Notes

To use the new features:
1. Rebuild the interpreter: `dart compile exe main.dart -o build/ws-linux`
2. Update your scripts to use the new syntax where beneficial
3. Test your existing scripts to ensure they work correctly

## Version

- **Version:** 1.0.3
- **Previous Version:** 1.0.2
- **Release Date:** November 30, 2025

## Summary

v1.0.3 brings quality-of-life improvements focused on:
- **Convenience:** `+=` and `-=` operators
- **Control Flow:** `break` statement
- **String Manipulation:** `.length()` and `.letter(index)` methods
- **User Experience:** Removed verbose logging

These features make Well.. Simple more ergonomic for everyday programming tasks!
