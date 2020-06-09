
# Union File System

## Definition
---
- Allows files and directories of different file system (also known as branches) to be overlaid to form a single file system.
- UFS implements a union mount and operate by creating layers

## Docker
---
- Docker images are stored as a series of RO layers and when a container starts, Docker will take the RO image file, then the file is copied out of the uderlying RO layer and into the top-most RW layer where changes can be applied.
- The version of the RO file which is in the RW layer is hidden but not destroyed.
- When the container is deleted, the RW layer will be destroyed, however, the RO will remain unchanged.
- Docker uses UFS in conjuction with [copy-on-write](../01-CopyOnWrite.md) techniques to provide the building blocks for containers, making them very lightweight and fast.

## Illustration
---
![](https://blog.container-solutions.com/hs-fs/hubfs/understanding_volumes_in_docker.png?width=1200&name=understanding_volumes_in_docker.png)

## Sources
---
- [Understanding Docker Volumes](https://blog.container-solutions.com/understanding-volumes-docker#:~:text=In%20order%20to%20be%20able,files%20on%20the%20host%20filesystem.)
- [Docs.Docker](https://docs.docker.com/glossary/)

##### [Back-to-Index](../../00-Index.md)