import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import sys
import os


if len(sys.argv) != 2:
    print("Usage: python %s file1.tsv file2.tsv",sys.argv[0])
    sys.exit(1)

csv_file = sys.argv[1]

# Check if file exists
if not os.path.exists(csv_file):
    print(f"Error: {csv_file} not found. Please provide the correct file.")
    exit(1)

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
plt.savefig("threads_chart.png", dpi=300)
plt.show()
