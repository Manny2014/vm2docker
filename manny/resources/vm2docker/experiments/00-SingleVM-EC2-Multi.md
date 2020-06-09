# Experiment/Setup - 3

## Single UBUNTU (18.04) VM Running Container on that EC2 Instance (No Process,No Packages)

- Agent & Chief will run on different nodes
- Chief will not run inside container
- Will export env var DOCKER_HOST to point to my target VM
- Will no include any processes

### Commands:

#### Run Agent
```bash
sudo ./agent
```

#### Run Chief - In Container

```bash
cd /var/lib/vm2docker
# Clone my fork
git clone https://github.com/Manny2014/vm2docker.git
cd vm2docker/chief
# Install requirements
pip install -r requirements.txt

# Build code
make
sudo ./vm2docker.py --debug --no-packages --no-processes --no-run --tag vanilla-1 172.31.84.253 49153
```

##### Errorr Results
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

#### Error Source
- .tar is too large for the *Add modded.tar /* instruction

#### Output from VM2Docker
```text
From size: 71140K	/tmp/tmpFRjrPV/root_fs/

To size: 2838828K	/tmp/tmpFRjrPV/vm_root/

Diff between parent and child contains:
934 modifications and additions, 21 deletions
Deletions total 68205 bytes
Additions total 2716082484 bytes
Size of /tmp/tmp2a9UfI/modded.tar: 2556.11 MB
```