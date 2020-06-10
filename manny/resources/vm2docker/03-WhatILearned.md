
# VM2 Docker - What Did I Learn?

## Learning Points
---
- I learned how docker leverages all the low-level concepts we learned in class such as:
    - overlayfs -> shared mounting
    - namespaces -> container run and how it uses the same files leveraging mounting
- I learned about some limitations of docker
    - I've been working with docker for a few years now and I've never tried to do an ADD on a large .tar and didn't realize this could cause problems
    - If time wasn't an issue, i feel like i could figure this out but was not able to.
- Dependency Dection
    - I thought the way that the developers of the VM2Docker program were very about their implementation, specifically around package detection

##### [Back-to-Index](../../00-Index.md)