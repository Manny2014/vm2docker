# Copy-On-Write

## Definition
---
- Refers to explict sharing or shadowing
- It's a resource managment technique to efficiently implement a "duplicate" or "copy" operation on a modifiable resoure.
- Particularly useful in virtual memory management, as an example, the fork system call.

## Docker
---
- Docker uses the copy-on-right technique and the [union file system](00-UnionFileSystem.md) for both images and container to optimize resources and speed performance.
- Multiple containers can share access to the same image, and make contaienr-specific changes on a writabe layer which is delted when the container is removed.
- Images are essentially layers of filesystems typically predicated on a base image under a writable layer, and built up with layers of differences from the base image which minimizes the footprint of the images and enables shared develoment.

## Illustration
---
![](https://image.slidesharecdn.com/developqnapnasappbydocker-160510125436/95/develop-qnap-nas-app-by-docker-18-638.jpg?cb=1463789993)

## Sources
---
- [Docs.Docker](https://docs.docker.com/glossary/)

##### [Back-to-Index](../../00-Index.md)
