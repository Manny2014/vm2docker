# Experiment/Setup - 1

## Single UBUNTU (18.04) VM Running Container on that Antsle VM (No Process,No Packages)

- Agent & Chief are on the same node
- Will export env var DOCKER_HOST to point to my target VM
- Will use my Mac's docker client to connect to remote dockerd
- Will no include any processes

### Commands:

#### Run Agent
```bash
sudo ./agent
```

#### Run Chief - In Container
```bash
export DOCKER_HOST="tcp://192.168.1.120:2375"

# Build Container 
docker build -t manny87/vm2docker .

# Run VM2Docker (Agent should be running on node on target VM)
docker run -it -e DOCKER_HOST="tcp://192.168.1.120:2375" manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 192.168.1.120 49153
```

##### Results 
- Internal server kept crashing
- Decided that fixing that was not in scope and should move on to AWS EC2.


##### [Back-to-Index](../../../00-Index.md)