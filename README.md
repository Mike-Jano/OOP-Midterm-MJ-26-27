# Mike Janosky's OOP Midterm Project.

## Introduction

Currently, our Zombie Simulation has a scalability issue. Simply running a simulation with a total of 100 agents will yield acceptable results and performance. Although, scaling the simulation's agent count up to the thousands, or even the millions, will cause my current simulation substantial issues. The current simulation already uses PosgreSQL's DBMS to manage all of the agent's information.

Our current issue is that our simulation is currently bottle-necked by the DBMS's speed. While a DBMS is capable of handling a sizable amount of data through the system host's hard drive, the performance is significantly less compared to that of the host's memory. Memory is designed to handle data swiftly. Capitalizing on the speed of memory will help increase the performance of the Zombie Simulation.

Completely switching our data handling process from a DBMS to system memory is not the complete solution however. The way memory is designed, memory is built to handle low amounts of data swiftly. This means that memory would not solve our lack of scalability either.

## Solution

After discussing the pros and cons of both a DBMS and memory storage, we begin to notice a trait about the two. They act in complete opposite ways to one another. A DBMS handles lots of data, but slowly; memory handles bits of data, but hastily. The perfect thing about the handlers is that they are able to work together, combining their two strengths.

If it were as simple as iterating through the agent_id's from the database and bringing them to the host's memory, we would have already been done reading. Instead we have a two main questions that must be answered before we have a solid solution to our original problem.

Problem #1: How many agents can we bring from the database to the main memory at a time?

Problem #2: How do we know which agents we should bring from the database to the main memory?

I will attempt to solve both of these problems while providing snippets of code alongside them.

## Problem #1: How many agents can we bring from the database to the main memory at a time?

The key limiter of how many agents we could bring into the main memory in a single time is based on how much memory the system has. Specifically, how much memory the system has available at a single time. Not all systems are built equal. A computer with only 8 GB of RAM would complete a simulation substantially slower than one with 32 GB. How can we optimize this? A tool called **psutil** is able to achieve exactly this. The perfect thing about using this utility is that it is compatible on Windows, MacOS, and Linux. The only drawback is that this utility needs to be downloaded, meaning that we will have to add it to an initializer file, along with a **virtual environment** folder so that the tool is not installed system-wide.

The image below shows us using a terminal window connected to the virtual environment installing the **psutil** utility package:

<img width="528" height="170" alt="Install" src="https://github.com/user-attachments/assets/b1b6487e-36f5-461c-beaf-25a32999671a" />

Below is a simple snippet of code that extracts the system host's total memory, available memory, along with the percentage of memory in use:

<img width="491" height="247" alt="Code" src="https://github.com/user-attachments/assets/53946fca-e691-4f70-a227-22912a69f49e" />

With the code above, we get a basic output from the prior script is printed below:

<img width="345" height="150" alt="Output" src="https://github.com/user-attachments/assets/d8324932-4dff-430e-bcea-dda117ca87b9" />

The data we achieve via this simple script is crucial to determining how many agents can be ran on a system at a time. We can determine from the image above that our system has approximately 15.28 GB of RAM. Despite this, only 3.02 GB of the 15.28 GB is available for us to use in our simulation.


