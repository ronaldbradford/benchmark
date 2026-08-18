import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import sys
import os


if len(sys.argv) != 3:
    print(f"Usage: python {sys.argv[0]} <log-file-path> <log-file-pattern>")
    sys.exit(1)

log_file_path = sys.argv[1]
input_file_pattern = sys.argv[2]
if not input_file_pattern.endswith("."):
    input_file_pattern += "."

csv_file = os.path.join(log_file_path, f"{input_file_pattern}threads.csv")
png_file = os.path.join(log_file_path, f"{input_file_pattern}threads.png")

# Check if file exists
if not os.path.exists(csv_file):
    print(f"Error: {csv_file} not found. Please provide the correct file.")
    sys.exit(1)

# Read CSV file
df = pd.read_csv(csv_file)

# Create figure and axes
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Line chart for Avg and 95th Percentile
axes[0].plot(df["Threads"], df["Avg"], marker="o", label="Avg", linestyle="-", color="blue")
axes[0].plot(df["Threads"], df["95th"], marker="s", label="95th Percentile", linestyle="--", color="red")
axes[0].set_xlabel("Threads")
axes[0].set_ylabel("Latency (ms)")
axes[0].set_title("Latency: Average vs. 95th Percentile")
axes[0].legend()
axes[0].grid(True)
axes[0].set_xticks(df["Threads"])

# Bar chart with equally spaced bars
x_positions = np.arange(len(df["Threads"]))  # Create equally spaced positions
bar_width = 0.6  # Adjust bar width for better spacing

axes[1].bar(x_positions, df["Transactions"], width=bar_width, color="green", alpha=0.7)
axes[1].set_xlabel("Threads")
axes[1].set_ylabel("Transactions per Second")
axes[1].set_title("Transactions per Second by Threads")
axes[1].set_xticks(x_positions)  # Set equally spaced x-ticks
axes[1].set_xticklabels(df["Threads"])  # Use actual thread values as labels
axes[1].grid(axis="y")

# Adjust layout and display
plt.tight_layout()
print(f"Creating '{png_file}'")
plt.savefig(png_file, dpi=300)
