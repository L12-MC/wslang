# Dashboard GUI Demo - Multiple Widgets

print("Creating a dashboard GUI...")

gui.window(900, 700, "Application Dashboard")

# Header
gui.label(300, 20, "Dashboard Overview")

# Left Panel - Menu
gui.label(30, 70, "Menu")
gui.button(30, 100, 200, 35, "Home")
gui.button(30, 145, 200, 35, "Profile")
gui.button(30, 190, 200, 35, "Settings")
gui.button(30, 235, 200, 35, "Logout")

# Center Panel - Content
gui.label(280, 70, "Welcome Back!")
gui.label(280, 100, "You have 3 new notifications")

gui.label(280, 150, "Quick Actions:")
gui.button(280, 180, 150, 35, "New Project")
gui.button(450, 180, 150, 35, "View Reports")

# Input Section
gui.label(280, 250, "Search:")
gui.input(280, 280, 400, 35)
gui.button(690, 280, 100, 35, "Go")

# Right Panel - Info
gui.label(720, 70, "Stats")
gui.label(720, 100, "Users: 142")
gui.label(720, 130, "Active: 38")
gui.label(720, 160, "Tasks: 12")

# Bottom Status Bar
gui.label(30, 650, "Status: Connected | Last Update: Just now")

print("Opening dashboard...")
gui.show()

print("Dashboard is open! Keeping visible for 20 seconds...")
sleep(20000)

gui.close()
print("Dashboard closed.")
