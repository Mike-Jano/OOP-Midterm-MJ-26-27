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

The following three code snippets can be found in **[memory_scan.py](https://github.com/Mike-Jano/OOP-Midterm-MJ-26-27/blob/main/Memory%20Testing/memory_scan.py)** in the **Memory Testing** folder.
The image below shows us using a terminal window connected to the virtual environment installing the **psutil** utility package:

<img width="528" height="170" alt="Install" src="https://github.com/user-attachments/assets/b1b6487e-36f5-461c-beaf-25a32999671a" />

Below is a simple snippet of code that extracts the system host's total memory, available memory, along with the percentage of memory in use:

<img width="491" height="247" alt="Code" src="https://github.com/user-attachments/assets/53946fca-e691-4f70-a227-22912a69f49e" />

With the code above, we get a basic output from the prior script is printed below:

<img width="345" height="150" alt="Output" src="https://github.com/user-attachments/assets/d8324932-4dff-430e-bcea-dda117ca87b9" />

The data we achieve via this simple script is crucial to determining how many agents can be ran on a system at a time. We can determine from the image above that our system has approximately 15.28 GB of RAM. Despite this, only 3.02 GB of the 15.28 GB is available for us to use in our simulation. The **available_gb** variable, found in the image above, is the key factor to determining how many agents could be brought to our system's main memory at a single time.

Since we are using Python, the amount of space a single agent may consume in memory is higher than the average language. By using a utility called **pympler**, we can see how much memory is being consumed by a single agent in memory. In the folder titled "Memory Testing", you can find the script to the code to determine the following output (or follow this [link](https://github.com/Mike-Jano/OOP-Midterm-MJ-26-27/blob/main/Memory%20Testing/agent_consumption.py)). Below is the output to the script.

<img width="171" height="133" alt="image" src="https://github.com/user-attachments/assets/74419f8a-ebd9-403e-8ed2-2b1e4f33b06d" />

This shows us that a single agent, of either a zombie or human, consumes about 368 bytes (not bits) of data.

Looking at the amount of space the agents take up, we could think that thousands of agents could easily be maintained via only memory. That would be true if the agents were the only process being handled by the memory. Remember, the reason we need the agents in memory is to process data around them quickly. If the agents consume all of the memory, then there would be no room for running any of the processes. This leads us to our next problem.

## Problem #2: How do we know which agents we should bring from the database to the main memory?

This second key problem intercepts exactly where we form a problem determining how many agents should be in memory. We know that we should limit how many agents we should bring to the system's main memory, but how do we determine **WHICH** agents should and shouldn't be. We could answer this by simply understanding how the simulation works. What calculations are being made in the simulation? **Distances**. We will decide which agents are loaded to the memory based on their location in the simulation's environment. 

Simply saying we'll pick agents "based on location" is quite a broad approach to the solution, with numerous ways to go about handling the task. I will provide a few ways we could go about it. Let's imagine the simulation environment as a grid plane such as the one below.

<img width="800" height="800" alt="image" src="https://github.com/user-attachments/assets/b94390a7-9e35-4000-91e4-e5539ecb1307" />

It would be easy for us to tell our DBMS to load agents into the simulation based on which quadrant they reside. Agents in Quadrant 1 can be spotted if both their coordinates are positive. Q2 if x = + & y = -; Q3 if x = - & y = -; Q4 if x = - & y = +. With these parameters, the environment below would function.

<img width="747" height="750" alt="image" src="https://github.com/user-attachments/assets/5b4f951c-a594-4a84-8bd9-3aafd6af7c56" />

A problem with this system, however, is it doesn't meet our goals of scalability. It is true that this system will function in deciding which agents will load by position, but a substantial increase in agents will lead to no scale in the process of loading agents. An upgraded version of this system we can develop can have more sectors be created based on the number of agents there are in the DBMS.

<img width="748" height="748" alt="image" src="https://github.com/user-attachments/assets/5ef164aa-fe15-4da0-be92-0c7dffd3d49d" />

The new grid system is **NOT** only limited to 16 sectors, the sectors would continue to increase depending on the current population of agents in the DBMS. With this added onto our old system, we now can scale the number of agents that can be on the DBMS, without seeing a hit in performance in our simulation. 
