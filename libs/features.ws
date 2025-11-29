# Well.. Simple Language - JSON Examples

print("=== JSON Examples ===\n")

# JSON stringify
data = [1, 2, 3, 4, 5]
print("List to JSON:")
json.stringify(data)

print("")

# JSON parse
jsonText = "[10, 20, 30, 40]"
print("Parse JSON:")
json.parse(jsonText)

print("\n=== File I/O ===\n")

# Write to file
content = "Hello from Well.. Simple!"
writeFile("test_output.txt", content)

# Read from file
print("Reading file:")
readFile("test_output.txt")

print("\n=== Cryptography ===\n")

# MD5 hash
text = "Hello World"
print("MD5 hash of 'Hello World':")
hash.md5(text)

# SHA256 hash
print("\nSHA256 hash of 'Hello World':")
hash.sha256(text)

# Base64 encoding
print("\nBase64 encode 'Hello World':")
encode.base64(text)

# Base64 decoding
encoded = "SGVsbG8gV29ybGQ="
print("\nBase64 decode:")
decode.base64(encoded)

print("\n=== Try/Except/Finally ===\n")

# Try block example
try
  print("In try block")
  x = 10
  y = 0
  print("This will work")
except
  print("Error occurred!")
  print(error)
finally
  print("Finally block always executes")
end

print("\nAll examples complete!")
