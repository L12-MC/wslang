# File I/O Operations

Well.. Simple provides built-in functions for reading and writing files.

## Writing Files

### writeFile Function

Write text content to a file:

```ws
writeFile("output.txt", "Hello, World!")
```

**Syntax:**
```ws
writeFile(filename, content)
```

- `filename`: String - path to the file
- `content`: String - text to write

### Examples

#### Write Simple Text
```ws
text = "Hello from Well.. Simple!"
writeFile("greeting.txt", text)
```

#### Write Multiple Lines
```ws
line1 = "First line"
line2 = "Second line"
content = line1 + "\n" + line2
writeFile("multiline.txt", content)
```

#### Write Data
```ws
name = "Alice"
age = 30
data = "Name: " + name + ", Age: " + age
writeFile("person.txt", data)
```

#### Write JSON
```ws
numbers = [1, 2, 3, 4, 5]
jsonText = json.stringify(numbers)
writeFile("data.json", jsonText)
```

## Reading Files

### readFile Function

Read text content from a file:

```ws
readFile("input.txt")
```

**Syntax:**
```ws
readFile(filename)
```

- `filename`: String - path to the file to read

The content is printed to the console.

### Examples

#### Read and Display
```ws
print("File contents:")
readFile("data.txt")
```

#### Read with Error Handling
```ws
try
  readFile("config.txt")
except
  print("Could not read config file")
  print(error)
end
```

## File Paths

### Relative Paths
```ws
# Current directory
readFile("data.txt")

# Subdirectory
readFile("data/input.txt")

# Parent directory
readFile("../settings.txt")
```

### Absolute Paths
```ws
# Linux/Mac
readFile("/home/user/file.txt")

# Windows (use forward slashes)
readFile("C:/Users/user/file.txt")
```

## Common Patterns

### Read, Process, Write
```ws
# Read input
try
  content = readFile("input.txt")
  
  # Process
  parts = split(content, ",")
  result = parts[0]
  
  # Write output
  writeFile("output.txt", result)
  print("Processing complete")
except
  print("Error processing file")
  print(error)
end
```

### CSV File Processing
```ws
try
  # Read CSV
  csvData = readFile("data.csv")
  
  # Split into lines (conceptually)
  print("CSV data loaded")
  
  # Process each line
  lines = split(csvData, "\n")
  # ... process lines ...
  
except
  print("Error reading CSV")
end
```

### Configuration File
```ws
def loadConfig(filename)
  try
    readFile(filename)
    print("Config loaded")
  except
    print("Using default configuration")
    # Set defaults here
  end
end

loadConfig("config.txt")
```

### Log File Writing
```ws
def log(message)
  timestamp = "2024-01-01"  # Would use real timestamp
  entry = timestamp + ": " + message + "\n"
  
  try
    # In real implementation, would append
    writeFile("app.log", entry)
  except
    print("Could not write to log")
  end
end

log("Application started")
log("Processing data")
log("Application finished")
```

### Data Export
```ws
# Prepare data
names = ["Alice", "Bob", "Charlie"]
scores = [85, 90, 78]

# Build output
output = "Name,Score\n"
for i in range(0, length(names))
  line = names[i] + "," + scores[i] + "\n"
  output = output + line
end

# Write to file
writeFile("results.csv", output)
print("Data exported to results.csv")
```

### Backup Files
```ws
def backup(filename)
  try
    # Read original
    content = readFile(filename)
    
    # Write backup
    backupName = filename + ".bak"
    writeFile(backupName, content)
    print("Backup created: " + backupName)
  except
    print("Could not create backup")
    print(error)
  end
end

backup("important.txt")
```

## Working with JSON Files

### Save JSON
```ws
# Create data
person = "{'name': 'Alice', 'age': 30}"

# Write to file
writeFile("person.json", person)
```

### Load JSON
```ws
try
  # Read file
  jsonText = readFile("data.json")
  
  # Parse JSON
  data = json.parse(jsonText)
  print("JSON loaded successfully")
except
  print("Error loading JSON file")
  print(error)
end
```

## Error Handling

### File Not Found
```ws
try
  readFile("nonexistent.txt")
except
  print("File does not exist")
  print(error)
finally
  print("Read attempt completed")
end
```

### Write Failure
```ws
try
  writeFile("/restricted/file.txt", "content")
except
  print("Cannot write to file")
  print(error)
end
```

### Safe File Operations
```ws
def safeRead(filename)
  try
    readFile(filename)
  except
    print("Could not read: " + filename)
    print(error)
  end
end

def safeWrite(filename, content)
  try
    writeFile(filename, content)
    print("Saved: " + filename)
  except
    print("Could not write: " + filename)
    print(error)
  end
end
```

## Best Practices

1. **Always use try/except**: Wrap file operations in error handling
2. **Check file exists**: Handle missing files gracefully
3. **Use descriptive filenames**: Make file purposes clear
4. **Clean up**: Use finally blocks for cleanup operations
5. **Handle paths correctly**: Use forward slashes in paths
6. **Validate content**: Check file content before processing
7. **Log errors**: Keep track of file operation failures

## Limitations

Current limitations:
- Cannot append to files (overwrites existing content)
- No file existence checking
- No directory operations (mkdir, listdir, etc.)
- No file deletion
- No binary file support
- File content must fit in memory

## Future Enhancements

Planned features:
- File append mode
- Directory operations
- File existence checking
- File deletion
- File copying/moving
- Binary file support
- Streaming large files
- File metadata (size, date, permissions)

## Security Notes

- Be careful with file paths
- Validate input filenames
- Don't expose sensitive paths
- Use try/except to prevent crashes
- Consider permissions when writing files
