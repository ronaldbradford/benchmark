import matplotlib.pyplot as plt
import pandas as pd
import sys
import re

# Check for input files
if len(sys.argv) < 2:
    print("Usage: python plot_latency_multi.py file1.tsv file2.tsv ...")
    sys.exit(1)

# Initialize the plot
plt.figure(figsize=(10, 6))

# Define a set of distinct colors for multiple lines
colors = ["#3498DB", "#2ECC71", "#F39C12", "#9B59B6", "#1ABC9C", "#D35400", "#7F8C8D", "#FF33A8"]

# Regular expression to extract NN from filenames like 00NN.tsv
pattern = re.compile(r"0(\d+)\.tsv")

# Plot each file
for i, filename in enumerate(sys.argv[1:]):
    # Read the TSV file into a pandas DataFrame
    df = pd.read_csv(filename, sep="\t")

    # Check if the file has at least two columns
    if df.shape[1] < 2:
        print(f"Skipping {filename}: File does not have at least two columns.")
        continue

    # Extract X and Y values
    x_values = df.iloc[:, 0]  # First column (X-axis)
    y_values = df.iloc[:, 1]  # Second column (Y-axis)

    # Extract NN from filename
    match = pattern.search(filename)
    label = f"{match.group(1)}" if match else filename

    # Plot the data
    plt.plot(x_values, y_values, label=label, color=colors[i % len(colors)], marker='o', markersize=4, linestyle='-')

# Configure the chart
plt.xlabel("Query Time (ms)")
plt.ylabel("Transactions")
plt.title("Throughput Latency Distribution (95th Percentile)")
plt.ylim(0)  # Ensure Y-axis starts at 0
plt.legend(title="Threads")
plt.grid(True)

# Save and show the plot
plt.savefig("latency_chart.png", dpi=300)
plt.show()
