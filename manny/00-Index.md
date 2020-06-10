# **VM2Docker - Emmanuel Rodriguez** 


## Topics
---
- [Union file system](resources/definitions/00-UnionFileSystem.md)
- [Copy-on-write](resources/definitions/01-CopyOnWrite.md)
- [Union Mount](resources/definitions/02-UnionMount.md)

## VM2Docker Overview
---
- [VM File System Conversion](resources/definitions/vm2docker/00-FileSystemConversion.md)
- [Process Detection](resources/definitions/vm2docker/01-ProcessDetection.md)
- [Architecture](resources/definitions/vm2docker/02-Architecture.md)

## Experiments
---

### Setup & Run-as-is

#### Setup
- [Single Antsle VM From Mac Container](resources/vm2docker/00-SingleVM-Mac.md)
- [Single EC2 VM](resources/vm2docker/01-SingleVM-EC2-Single.md)
- [Multi EC2 VM](resources/vm2docker/02-SingleVM-EC2-Multi.md)

### General Issues 
- Dockerfile was outdated
- Initial AWS instance ran out of space on disk
- Had to increase the storage of the VM from 8G to 200G
    - As the code stands, it pulls EVERY image from docker hub

### Modifications
- Update Docker Py to latest version
- Fixed bug where it pulled ALL images
- Updated Dockerfile to ensure packages are installed correctly
- Fixed issue when running vm2docker in a container with tmp dir permissions