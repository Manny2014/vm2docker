
# VM2 Docker - Filesystem Conversion

## Overview
---
- The object of the filesystem conversion is broken down into three steps
    1. Map VM OS version with an exiting container image available in Docker hub
    2. Assemble additional layers required based on installed packages on the given VM
    3. Apply a diff-based algorithm to create account for other files not accounted for by the previous steps.
- Motivation
    - Space savings
        - Leverage Docker filesystem layering by inhering from a "parent" image.
        - VM image distribution will be faster.
    - Lack of industry solutions

## Base Image Step
---
- VM2Docker will pull the OS information for */etc/os-release* file available in Linux distributions.
- From that information, it will attempt to "pull" a container image from Docker hub.
    - Most linux distributions provide a base docker image and make it available in Docker hub.

## Depenency Detection
---
- Strives to remove any packages which were indirectly installed by other packages as dependencies, thus, reducing the overall size of the image.
- It is accomplished by using a directed graph of all packages that will be installe, where there's an ege from *A->B* if and only if A depends on B.

## Package Management
---
- Leverges the provided VM's package management solutions (ex: yum, apt-get, ect..), to determine all of the currently installed packages on the system.
- Maximize layering by first computing the intersection of packages for all VM's of the same operating system and release. 
- Once filtered, a Dockerfile will be generated that inherits from the image created in the previous step and installs the remaining packages specific to the provided VM.
    - ![Directed Graph](../imgs/DependencyDetectionDig.png)

### Diff Strategy
- Two strategies were evaluated: 
    1. rsync
    2. rdiffdir
- *rsync* 
    - is a backup tool used to sync changes to and from a remote server
    - Requires two rounds to account for additions, modifications, and deletions.
        1. Docker image -> VM filesystem
            - Will provide additions
        2. VM filesystem -> Docker image
            - Will provide deletions
    - Output is extracted to a tarball after removing all deletions provided by the second run of rsync which should equal the VM.

## Dockerfile
---
- VM2Docker has implementations for CentOS, Ubuntu, and Mageia which will provid the the image specific package installation instructions


##### [Back-to-Index](../../00-Index.md)