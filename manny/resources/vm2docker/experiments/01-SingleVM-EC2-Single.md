# Experiment/Setup - 2

## Single UBUNTU (18.04) VM Running Container on that EC2 Instance (No Process,No Packages)

- Agent & Chief are on the same node
- Will export env var DOCKER_HOST to point to my target VM
- Will not include any processes and packages


### Instructiions:

#### Do AWS Instance Setup
- [Instane Info](../setup/00-AWS-Setup.md)
  - We'll let INSTANCE_IP be the public IP of the instance

#### Run Agent
```bash
# LOG IN TO YOUR HOST
ssh -i ~/.ssh/ec2.pem  ubuntu@${INSTANCE_IP}

# GO TO VM2DOCKER WORKING DIR
cd /var/lib/vm2docker/vm2docker/agent

# START AGENT (userdata.sh will have compiletd it already)
sudo ./agent
```

#### Build Docker Image (FROM LOCAL LAPTOP)

```bash
# EXPORT DOCKER_HOST TO TEL YOUR CLIENT TO USE A REMOTE DAEMON
export DOCKER_HOST="tcp://${INSTANCE_IP}:2375"

# Build Container -> Will be pushed to target VM
docker build -t manny87/vm2docker .

# THE IMAGE WILL NOW BE AVAILABLE ON REMOTE HOST
docker images

manny@Emmanuels-MBP:~/git/opensource/vm2docker$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
manny87/vm2docker   latest              de275e3cd984        36 seconds ago      471MB
ubuntu              14.04               6e4f1fe62ff1        5 months ago        197MB
```

#### Run Chief

```bash
# LOG IN TO YOUR HOST ON ANOTHER SHELL
ssh -i ~/.ssh/ec2.pem  ubuntu@${INSTANCE_IP}

# Run VM2Docker (Agent should be running on node on target)
# Will work off of /var/lib/vm2docker which will be ignored by the tar operation executed by the agent
mkdir tmp
docker run -it --privileged -v $(pwd)/tmp:/tmp  -e DOCKER_HOST=tcp://$(hostname -f):2375 manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 $(hostname -f) 49153
```

#### Errorr Results
```error
" 200 None
Traceback (most recent call last):
  File "./vm2docker.py", line 97, in <module>
    image_gen.generate(tag_name, run_locally=args.run, tar_options=args.tar_options, diff_tool=args.diff_tool, processes=args.processes)
  File "/var/lib/vm2docker/vm2docker/chief/filesystem.py", line 212, in generate
    build.build(vm_tag)
  File "/var/lib/vm2docker/vm2docker/chief/dockerfile.py", line 90, in build
    stream = self.docker_client.images.build(path=self.dir,tag=tag) # TODO: Updated by manny
  File "/home/ubuntu/.local/lib/python2.7/site-packages/docker/models/images.py", line 287, in build
    raise BuildError(chunk['error'], result_stream)
docker.errors.BuildError: failed to copy files: Error processing tar file(exit status 1): operation not permitted
```

#### Issues 
- Initial instance ran out of space on disk
- Had to increase the storage of the VM from 8G to 200G
    - As the code stands, it pulls EVERY image from docker hub

##### [Back-to-Index](../../../00-Index.md)