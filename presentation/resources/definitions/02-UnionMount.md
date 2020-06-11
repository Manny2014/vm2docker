# Union Mount

## Definition
---
- Is way of comibing multiple directories into that appears to contain their combined contents.
- An early use case was the need to update information on CD-ROM's since they are not writeable, we can overlay the CD's mount point with a writable directory.

## Docker
---
- Docker uses OverlayFS filesystem service for Linux which implements the union mount for other systems. 
- It is supported by the Docker daemon as a storage driver.

## Illustration
---
![](https://hostineer.com/images/elastic/filesystem.png)

## Sources
---
- [Docs.Docker](https://docs.docker.com/glossary/)

##### [Back-to-Index](../../00-Index.md)
