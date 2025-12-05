# System Commands and Subprocess

Well.. Simple provides multiple ways to interact with the operating system and run external commands.

## Command Execution

### os.command(cmd)

Execute a system command and return its exit code:

```
os.command("echo Hello World")
```

Output:
```
Hello World
0
```

The function prints:
1. Standard output (stdout)
2. Standard error (stderr) if any
3. Exit code (0 for success, non-zero for errors)

### command(cmd)

Alternative syntax for `os.command()`:

```
command("ls -la")
```

Both `os.command()` and `command()` work identically.

## Assignment Support

You can capture the exit code in a variable:

```
status = os.command("some-command")
print(status)
```

Note: Only the exit code is captured, not the output.

## Subprocess Commands

### subprocess.run(cmd)

Run a command synchronously and display structured output:

```
subprocess.run("git status")
```

Output format:
```
stdout: <command output>
stderr: <error messages if any>
exitCode: <exit code>
```

### subprocess.start(cmd)

Start a command asynchronously (non-blocking):

```
subprocess.start("npm run dev")
print("Server starting in background...")
```

The process runs in the background and prints:
- Process ID (PID)
- Output as it's generated
- Errors as they occur

## Platform Differences

### Windows

Commands are executed using `cmd /C`:

```
os.command("dir")
os.command("type myfile.txt")
```

### Linux/macOS

Commands are executed using `bash -lc`:

```
os.command("ls -la")
os.command("cat myfile.txt")
```

## Sleep Function

Pause execution for a specified time:

```
sleep(1000)  # Sleep for 1 second (1000 milliseconds)
```

### Common Uses

```
# Delay before retry
print("Retrying in 5 seconds...")
sleep(5000)
retry_connection()

# Animation timing
for i in range(0, 10)
    print(i)
    sleep(500)  # Half second between prints
end

# Rate limiting
for url in urls
    fetch_data(url)
    sleep(1000)  # Wait 1 second between requests
end
```

## Complete Examples

### File Backup Script

```
print("Creating backup...")
os.command("cp important.txt important.backup")

# Verify backup
result = os.command("diff important.txt important.backup")
if result == 0
    print("Backup successful!")
else
    print("Backup verification failed!")
end
```

### Build and Deploy

```
print("Building project...")
subprocess.run("npm run build")

sleep(2000)

print("Deploying...")
subprocess.start("npm run deploy")

print("Deployment started in background")
```

### System Monitoring

```
while true
    print("=== System Status ===")
    
    os.command("date")
    os.command("uptime")
    
    print("Checking again in 60 seconds...")
    sleep(60000)
end
```

### Cross-Platform Commands

```
# Detect platform and run appropriate command
# (Note: This is conceptual - actual platform detection 
# would need to be added to the language)

# List files
os.command("ls")    # Linux/macOS
os.command("dir")   # Windows

# Clear screen
os.command("clear")  # Linux/macOS
os.command("cls")    # Windows
```

## Error Handling

Use try-except to handle command failures:

```
try
    os.command("nonexistent-command")
except
    print("Command failed!")
end
```

## Best Practices

1. **Check exit codes**: Always verify command success
2. **Handle errors**: Use try-except for critical commands
3. **Avoid hardcoding paths**: Make scripts portable
4. **Use subprocess.start() for long tasks**: Don't block execution
5. **Add delays carefully**: Use sleep() to avoid race conditions
6. **Quote paths with spaces**: Use proper escaping

## Security Considerations

1. **Validate input**: Don't run commands with unsanitized user input
2. **Avoid shell injection**: Be careful with string concatenation
3. **Use minimal privileges**: Run with least necessary permissions
4. **Log command execution**: Track what commands are run

## Performance Tips

- Use `subprocess.start()` for non-critical background tasks
- Add `sleep()` between resource-intensive operations
- Consider batch operations instead of many small commands
- Monitor resource usage for long-running processes
