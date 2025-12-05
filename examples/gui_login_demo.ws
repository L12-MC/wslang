# Login Form GUI Demo - Visual Window

print("===================================")
print("  Well.. Simple GUI Demo v1.2.0")
print("===================================\n")

print("Creating a login form...")

# Create window
gui.window(500, 400, "Login System")

# Title
gui.label(150, 30, "Welcome! Please Login")

# Username section
gui.label(50, 80, "Username:")
gui.input(50, 110, 380, 35)

# Password section
gui.label(50, 165, "Password:")
gui.input(50, 195, 380, 35)

# Buttons
gui.button(50, 260, 180, 45, "Login")
gui.button(250, 260, 180, 45, "Cancel")

# Footer
gui.label(150, 330, "v1.2.0 - Well.. Simple")

print("\nOpening GUI window in your browser...")
print("(The window will open automatically)")

gui.show()

print("\nGUI window is now visible!")
print("You should see a styled login form.")
print("\nKeeping window open for 15 seconds...")
print("(Press Ctrl+C to close early)")

sleep(15000)

print("\nClosing window and cleaning up...")
gui.close()

print("Demo complete!")
