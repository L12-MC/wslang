# Simple GUI Test - Visual Window Demo

print("Creating a simple GUI window...")

gui.window(600, 400, "Hello GUI World")
gui.label(50, 50, "Hello from Well.. Simple!")
gui.button(50, 100, 150, 40, "Test Button")

print("Opening window (should open in your browser)...")
gui.show()

print("Window is open! Press Ctrl+C to close, or wait 10 seconds...")
sleep(10000)

gui.close()
print("Done!")
