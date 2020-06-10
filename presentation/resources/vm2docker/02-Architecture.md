
# VM2 Docker - Architecture

## Overview
---
- VM2Docker has two components:
    1. Agent
    2. Chief

## Agent
- Written in C
- Will run on the target VM(s)
- Responsible for:
    - Extracting the filesystem
    - Retrieve package information from the given VM
    - Retrieving process information
    - Sending all filesystem .tar fiel to the chief

## Chief
- Written in Python
- Responsible for:
    - Submitting a request the agent to "start"
    - Receives .tar from Agent
    - Executes the *rsync* operations
    - Pulls the appropriate base image from Docker hub
    - Generates the Dockerfile for the given VM
    - Builds image

##### [Back-to-Index](../../00-Index.md)