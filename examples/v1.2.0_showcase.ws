# Well.. Simple v1.20 - New Features Demo

# System Commands
print("=== System Commands ===")
os.command("echo Hello from os.command")
command("echo Still works with command()")

# Sleep function
print("\n=== Sleep Demo ===")
print("Sleeping for 1 second...")
sleep(1000)
print("Done sleeping!")

# Subprocess commands
print("\n=== Subprocess Demo ===")
subprocess.run("echo Subprocess run command")

# GUI Library - Now shows actual visual window!
print("\n=== GUI Library Demo ===")
print("Creating visual GUI window...")

gui.window(800, 600, "Well.. Simple GUI Demo")
gui.label(50, 50, "Welcome to Well.. Simple v1.2.0!")
gui.label(50, 80, "This is a real GUI rendered in your browser")
gui.button(50, 120, 200, 40, "Click Me")
gui.button(270, 120, 200, 40, "Another Button")
gui.label(50, 180, "Enter your name:")
gui.input(50, 210, 300, 35)
gui.button(50, 270, 150, 40, "Submit")
gui.button(220, 270, 150, 40, "Cancel")

print("Opening GUI window in browser...")
gui.show()

print("Window is open! Keeping it visible for 5 seconds...")
sleep(5000)

print("Closing GUI window...")
gui.close()

# Class with methods
print("\n=== Class Demo ===")
class Calculator
    result = 0
    
    init(initial)
        this.result = initial
    end
    
    add(n)
        this.result = this.result + n
    end
    
    multiply(n)
        this.result = this.result * n
    end
    
    getResult()
        print(this.result)
    end
end

calc = new Calculator(10)
calc.add(5)
calc.multiply(2)
calc.getResult()

print("\n=== All features working! ===")
