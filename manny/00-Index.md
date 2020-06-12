# **VM2Docker - Emmanuel Rodriguez** 

## VM2Docker Overview/Background
---
- [VM File System Conversion](resources/vm2docker/00-FileSystemConversion.md)
- [Process Detection](resources/vm2docker/01-ProcessDetection.md)
- [Architecture](resources/vm2docker/02-Architecture.md)

## Experiments
---

### Setup & Run-as-is

#### Setup
- [Single Antsle VM From Mac Container](resources/vm2docker/experiments/00-SingleVM-Mac.md)
- [Single EC2 VM](resources/vm2docker/experiments/01-SingleVM-EC2-Single.md)
    - [AWS EC2 Node Setup](resources/vm2docker/setup/00-AWS-Setup.md)
- [Multi EC2 VM](resources/vm2docker/experiments/02-SingleVM-EC2-Multi.md)

### General Issues 
- Dockerfile was outdated
- Initial AWS instance ran out of space on disk
- As the code stands, it pulls EVERY image from docker hub
    - Fixed that by using label with version
    
### Modifications
- Update Docker Py to latest version
- Fixed bug where it pulled ALL images
- Updated Dockerfile to ensure packages are installed correctly
- Fixed issue when running vm2docker in a container with tmp dir permissions
