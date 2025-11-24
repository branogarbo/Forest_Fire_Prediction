import pandas as pd

# Define the mapping of month abbreviations to numbers
month_map = {
    'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4,
    'may': 5, 'jun': 6, 'jul': 7, 'aug': 8,
    'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12
}

# Replace this with your CSV filename
input_file = 'dataset.csv'
output_file = 'dataset_new.csv'

# Read the CSV
df = pd.read_csv(input_file)

# Convert the 'month' column to lowercase and map abbreviations to numbers
df['month'] = df['month'].str.strip().str.lower().map(month_map)

# Write the updated data to a new CSV
df.to_csv(output_file, index=False)

print(f"Updated CSV saved as '{output_file}'")
