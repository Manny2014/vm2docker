# Experiment/Setup - 3

## Single UBUNTU (18.04) VM Running Container on that EC2 Instance (No Process,No Packages)

- Agent & Chief will run on different nodes
- Chief will not run inside container
  - It will have docker installed.
- Will no include any processes

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
##### Agent output
```test
172.31.95.13:49184 connected
CMD: get_filesystem -z
EXEC: tar -C / --exclude=sys --exclude=proc --exclude=dev --exclude=mnt --exclude=run/docker --exclude=var/run/docker --exclude=var/lib/docker --exclude=var/lib/lxcfs --exclude=var/lib/vm2docker -c . -z -f filesystem.tar.gz


tar: ./var/lib/lxd/unix.socket: socket ignored
tar: ./run/docker.sock: socket ignored
tar: ./run/containerd/containerd.sock: socket ignored
tar: ./run/containerd/containerd.sock.ttrpc: socket ignored
tar: ./run/snapd-snap.socket: socket ignored
tar: ./run/snapd.socket: socket ignored
tar: ./run/uuidd/request: socket ignored
tar: ./run/acpid.socket: socket ignored
tar: ./run/dbus/system_bus_socket: socket ignored
tar: ./run/user/1000/snapd-session-agent.socket: socket ignored
tar: ./run/user/1000/systemd/private: socket ignored
tar: ./run/user/1000/systemd/notify: socket ignored
tar: ./run/user/1000/gnupg/S.gpg-agent.ssh: socket ignored
tar: ./run/user/1000/gnupg/S.gpg-agent: socket ignored
tar: ./run/user/1000/gnupg/S.gpg-agent.extra: socket ignored
tar: ./run/user/1000/gnupg/S.dirmngr: socket ignored
tar: ./run/user/1000/gnupg/S.gpg-agent.browser: socket ignored
tar: ./run/lvm/lvmetad.socket: socket ignored
tar: ./run/lvm/lvmpolld.socket: socket ignored
tar: ./run/systemd/journal/syslog: socket ignored
tar: ./run/systemd/journal/socket: socket ignored
tar: ./run/systemd/journal/stdout: socket ignored
tar: ./run/systemd/journal/dev-log: socket ignored
tar: ./run/systemd/private: socket ignored
tar: ./run/systemd/notify: socket ignored
tar: ./run/systemd/inaccessible/sock: socket ignored
tar: ./run/udev/control: socket ignored
Writing to Socket: Size: 1183797888, Filename: filesystem.tar.gz
Sent 1183797888/1183797888 bytes successfully
```

##### Error Source
- .tar is too large for the *Add modded.tar /* instruction
```bash
ubuntu@ip-172-31-95-13:/var/lib/vm2docker/vm2docker/chief$ sudo su
root@ip-172-31-95-13:/var/lib/vm2docker/vm2docker/chief# cd /tmp/tmpPBwN0u
root@ip-172-31-95-13:/tmp/tmpPBwN0u# ls
Dockerfile  deleted.txt  modded.tar
root@ip-172-31-95-13:/tmp/tmpPBwN0u# cat Dockerfile 
FROM ubuntu:18.04
ADD modded.tar /
ADD deleted.txt /sbx/
RUN xargs -d '\n' -a /sbx/deleted.txt rm -r
RUN rm -rf /sbx/root@ip-172-31-95-13:/tmp/tmpPBwN0u# ls -lh
total 2.5G
-rw-r--r-- 1 root root  117 Jun  9 22:15 Dockerfile
-rw-r--r-- 1 root root  405 Jun  9 22:15 deleted.txt
-rw-r--r-- 1 root root 2.5G Jun  9 22:15 modded.tar

root@ip-172-31-95-13:/tmp/tmpPBwN0u# docker build -t blah .

Sending build context to Docker daemon   2.68GB
Step 1/5 : FROM ubuntu:18.04
 ---> c3c304cb4f22
Step 2/5 : ADD modded.tar /
failed to copy files: Error processing tar file(exit status 1): operation not permitted
```
##### Size of Tar
```bash
total 5.0G
-rwxr-xr-x 1 root root  20K Jun  9 23:20 agent
-rw-r--r-- 1 root root 4.6K Jun  9 23:20 agent.c
-rw-r--r-- 1 root root 7.2K Jun  9 23:20 agent.o
-rw-r--r-- 1 root root  340 Jun  9 23:20 centos.c
-rw-r--r-- 1 root root 8.4K Jun  9 23:20 cmds.c
-rw-r--r-- 1 root root  306 Jun  9 23:20 cmds.h
-rw-r--r-- 1 root root  11K Jun  9 23:20 cmds.o
-rw-r--r-- 1 root root 1.2K Jun  9 23:20 constants.h
-rw-r--r-- 1 root root 5.0G Jun 10 00:08 filesystem.tar.gz
-rw-r--r-- 1 root root   86 Jun  9 23:20 interface.i
-rw-r--r-- 1 root root  305 Jun  9 23:20 mageia.c
-rw-r--r-- 1 root root 1.8K Jun  9 23:20 mageia.o
-rw-r--r-- 1 root root 2.8K Jun  9 23:20 Makefile
-rw-r--r-- 1 root root   74 Jun  9 23:20 os.h
-rw-r--r-- 1 root root  334 Jun  9 23:20 ubuntu.c
```

##### Output from VM2Docker
```text
From size: 71140K	/tmp/tmpFRjrPV/root_fs/

To size: 2838828K	/tmp/tmpFRjrPV/vm_root/

Diff between parent and child contains:
934 modifications and additions, 21 deletions
Deletions total 68205 bytes
Additions total 2716082484 bytes
Size of /tmp/tmp2a9UfI/modded.tar: 2556.11 MB
```

##### [Back-to-Index](../../../00-Index.md)