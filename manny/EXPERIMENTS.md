# Experiments

## Single UBUNTU (18.04) VM Running Container on that VM (No Process,No Packages)
- Will export env var DOCKER_HOST to point to my target VM
- Will use my Mac's docker client to connect to remote dockerd
- Will no include any processes

### Commands:

#### Run Agent
```bash
sudo ./agent
```

#### Run VM2Docker From Mac/Docker Client (Antsle/Internal Server)
```bash
export DOCKER_HOST="tcp://192.168.1.120:2375"

# Build Container 
docker build -t manny87/vm2docker .

# Run VM2Docker (Agent should be running on node on target VM)
docker run -it -e DOCKER_HOST="tcp://192.168.1.120:2375" manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 192.168.1.120 49153
```

##### Results 
- Internal server kept crashing
- After a few attempts created an EC2 Instance

#### Run VM2Docker From Mac/Docker Client (EC2 Instnce)
```bash
export DOCKER_HOST="tcp://34.236.37.227:2375"

# Build Container -> Will be pushed to target VM
docker build -t manny87/vm2docker .

# Run VM2Docker (Agent should be running on node on targe)
docker run -it --privileged -e DOCKER_HOST="tcp://0.0.0.0:2375" manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 $(hostname -f) 49153
```

##### Results 
- Initial instance ran out of space on disk
- Increased instance size (t2.micro -> ??)