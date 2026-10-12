# Scans a system's memory, printing out the total memory, available memory, and the percentage of memory in use

import psutil

memory = psutil.virtual_memory()

total_gb = memory.total / (1024 ** 3)
available_gb = memory.available / (1024 ** 3)

print(f"Total memory: {total_gb:.2f} GB")
print(f"Available memory: {available_gb:.2f} GB")
print(f"Memory usage: {memory.percent}%")
