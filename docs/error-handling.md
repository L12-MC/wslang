# Error Handling with Try/Except/Finally

Well.. Simple provides robust error handling with `try`, `except`, and `finally` blocks.

## Basic Try/Except

```ws
try
  # Code that might fail
  x = 10
  y = 0
  result = x / y
except
  # Handle the error
  print("An error occurred!")
end
```

## Try/Except with Error Message

The error message is automatically stored in the `error` variable:

```ws
try
  readFile("nonexistent.txt")
except
  print("Error: ")
  print(error)
end
```

## Try/Except/Finally

The `finally` block always executes, whether an error occurred or not:

```ws
try
  writeFile("output.txt", "Hello!")
  print("File written successfully")
except
  print("Error writing file")
  print(error)
finally
  print("Cleanup complete")
end
```

## Common Use Cases

### File Operations
```ws
try
  content = readFile("data.txt")
  print(content)
except
  print("Could not read file")
  print(error)
end
```

### JSON Parsing
```ws
jsonText = "{invalid json}"
try
  json.parse(jsonText)
except
  print("Invalid JSON format")
  print(error)
end
```

### Base64 Decoding
```ws
try
  decoded = decode.base64("invalid@base64")
  print(decoded)
except
  print("Invalid base64 string")
  print(error)
end
```

### Multiple Operations
```ws
try
  # Read file
  data = readFile("input.txt")
  
  # Process data
  parts = split(data, ",")
  
  # Write result
  writeFile("output.txt", parts[0])
  
  print("Success!")
except
  print("Operation failed")
  print(error)
finally
  print("Processing complete")
end
```

## Nested Try/Except

You can nest try/except blocks:

```ws
try
  data = readFile("data.json")
  
  try
    parsed = json.parse(data)
    print("JSON parsed successfully")
  except
    print("Invalid JSON in file")
  end
  
except
  print("Could not read file")
end
```

## Error Variable

The `error` variable contains the error message:

```ws
try
  x = 10
  y = 0
  z = x / y
except
  print("Error occurred: " + error)
end
```

## Best Practices

1. **Use specific error handling**: Catch errors close to where they occur
2. **Always clean up**: Use `finally` for cleanup operations
3. **Log errors**: Print or save error messages for debugging
4. **Graceful degradation**: Provide fallback behavior when errors occur
5. **Don't hide errors**: At minimum, log the error even if you handle it

## Examples

### Safe File Writer
```ws
def safeWrite(filename, content)
  try
    writeFile(filename, content)
    print("File saved: " + filename)
  except
    print("Failed to save file")
    print(error)
  finally
    print("Write operation completed")
  end
end

safeWrite("output.txt", "Hello, World!")
```

### Data Processor with Error Handling
```ws
def processData(filename)
  try
    # Read file
    content = readFile(filename)
    print("File read successfully")
    
    # Parse as JSON
    try
      data = json.parse(content)
      print("JSON parsed")
    except
      print("Not valid JSON, treating as text")
      data = content
    end
    
    print("Processing complete")
    
  except
    print("Could not process file: " + filename)
    print(error)
  finally
    print("Done")
  end
end
```

### Retry Logic
```ws
retries = 3
success = false

for i in range(0, retries)
  try
    content = readFile("data.txt")
    success = true
    print("File read successfully")
  except
    print("Attempt failed, retrying...")
  end
  
  if success == true
    # Break would go here if supported
  end
end

if success == false
  print("Failed after all retries")
end
```

## Error Types

Common errors you might encounter:

- **File not found**: When reading a non-existent file
- **Permission denied**: When accessing restricted files
- **Invalid JSON**: When parsing malformed JSON
- **Invalid base64**: When decoding invalid base64 strings
- **Division by zero**: Mathematical errors (though not caught by try/except currently)

## Limitations

- No specific exception types (all errors are generic)
- No custom exception throwing
- Error message format is implementation-dependent
- Cannot catch all runtime errors (some may still crash)

## Future Enhancements

Planned features:
- `throw` statement for custom errors
- Specific exception types
- Stack traces
- Error logging to files
