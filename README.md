# OOP-Midterm-MJ-26-27
## Mike Janosky's OOP Midterm Project.

## Introduction

Currently, our Zombie Simulation has a scalability issue. Simply running a simulation with a total of 100 agents will yield acceptable results and performance. Although, scaling the simulation's agent count up to the thousands, or even the millions, will cause my current simulation substantial issues. The current simulation already uses PosgreSQL's DBMS to manage all of the agent's information.

Our current issue is that our simulation is currently bottle-necked by the DBMS's speed. While a DBMS is capable of handling a sizable amount of data through the system host's hard drive, the performance is significantly less compared to that of the host's memory. Memory is designed to handle data swiftly. Capitalizing on the speed of memory will help increase the performance of the Zombie Simulation.

Completely switching our data handling process from a DBMS to system memory isn't the complete solution however. The way memory is designed, memory is built to handle low amounts of data swiftly. This means that memory would not solve our lack of scalability either.

## Solution

After discussing the pros and cons of both a DBMS and memory storage, we begin to notice a trait about the two. They act in complete opposite ways to one another. A DBMS handles lots of data, but slowly; memory handles bits of data, but hastily. The perfect thing about the handlers is that they are able to work together, combining their two strengths.
