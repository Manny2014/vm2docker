# Experiments

## Single UBUNTU VM Running Container on that VM (No Process,No Packages)
- Will export env var DOCKER_HOST to point to my target VM
- Will use my Mac's docker client to connect to remote dockerd
- Will no include any processes
- Exclude NFS mount directories
    - And any dir that's not important (have some since i've been using this VM through the course)

### Commands:

#### Run Agent
```bash
sudo ./agent
```

#### Run VM2Docker rom Mac/Docker Client
```bash

# Build Container 
docker build -t manny87/vm2docker .

# Run VM2Docker (Agent should be running on node)
docker run -it  --network host -e DOCKER_HOST="tcp://192.168.1.120:2375" manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 192.168.1.120 49153
```

#### Results
- VM Crashed
    - When i provided the DOCKER_HOST of the same host running the vm2docker container
- No result outputed
