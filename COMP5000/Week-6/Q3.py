# Q3: Creating a GUI

# Import and Setup
import tkinter as tk

window = tk.Tk()
tk.Label(window, text="SQL Command: ").grid(row=0)
tk.Entry(window).grid(row=0, column=1)

tk.Button(window, text="Quit", command=window.quit).grid(
    row=3, column=0, sticky=tk.W, pady=4)
tk.Button(window, text="Run SQL").grid(
    row=3, column=1, sticky=tk.W, pady=4)

tk.Radiobutton(window, text="AWS").grid(
    row=4, column=0)
tk.Radiobutton(window, text="SQLite").grid(
    row=4, column=1)

window.mainloop()
