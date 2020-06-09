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
# Will work off of /var/lib/vm2docker which will be ignored by the tar operation executed by the agent
mkdir tmp
docker run -it --privileged -v $(pwd)/tmp:/tmp  -e DOCKER_HOST=tcp://$(hostname -f):2375 manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 $(hostname -f) 49153
```
##### Results

##### Issues 
- Initial instance ran out of space on disk
- Had to increase the storage of the VM from 8G to 200G
    - As the code stands, it pulls EVERY image from docker hub

## Modifications
- Update Docker Py to latest version
- Fixed bug where it pulled ALL images
- Updated Dockerfile to ensure packages are installed correctly
- Fixed issue when running vm2docker in a container with tmp dir permissions
