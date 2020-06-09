
# VM2 Docker - Process Detections

## Overview
---
- Provides the ability to automatically configure the resulting containers in a manner similar to that of the original VM.

## Process Detection
--
- The Agent component which runs on the VM as root, will do a process detection on the running processes 
- Additionally, *netstat* is used to determine which ports are bound to the given process which will be translated into a *EXPOSE* instruction in the Dockerfile.
- Lastly, it will pull data from the */proc* filesystem to determine:
    - Environment variables
    - Working directory

##### [Back-to-Index](../../00-Index.md)