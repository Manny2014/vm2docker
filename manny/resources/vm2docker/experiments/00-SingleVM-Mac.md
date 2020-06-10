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

# Build Container 
docker build -t manny87/vm2docker .

# Run VM2Docker -> On local Mac

## Attempt #1: Non-Priv
docker run -it -v /var/run/docker.sock:/var/run/docker.sock manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 34.239.179.18 49153

## Attempt #2: Priv
sudo docker run -it --privileged  -v /var/run/docker.sock:/var/run/docker.sock manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 34.239.179.18 49153

## Attempt #3: Priv with mounted tmp dir
mdkdir .tmp
sudo docker run -it --privileged  -v $(pwd)/.tmp:/tmp -v /var/run/docker.sock:/var/run/docker.sock manny87/vm2docker:latest --debug --no-packages --no-processes --no-run --tag vanilla-1 34.239.179.18 49153
```

#### Results 

##### Chief log (Non-Priv & Priv Run)
```text
Starting conversion...
DOCKER_HOST=None
Trying paths: ['/root/.docker/config.json', '/root/.dockercfg']
No config file found
Trying paths: ['/root/.docker/config.json', '/root/.dockercfg']
No config file found
Obtaining filesystem from socket connection


960682966 bytes saved to /tmp/tmpRx8Trx/filesystem.tar.gz
Successfully obtained filesystem from socket connection
Extracting tar file
Extracting tar to /tmp/tmpS7FX2o/vm_root/
Traceback (most recent call last):
  File "./vm2docker.py", line 97, in <module>
    image_gen.generate(tag_name, run_locally=args.run, tar_options=args.tar_options, diff_tool=args.diff_tool, processes=args.processes)
  File "/src/chief/filesystem.py", line 142, in generate
    self.extract_tar(tar_path, new_vm_root)
  File "/src/chief/filesystem.py", line 125, in extract_tar
    return extract_tar(tar_path, target_dir, clean_up=not self.debug)
  File "/src/chief/utils/utils.py", line 79, in extract_tar
    tf.extractall(target_dir)
  File "/usr/lib/python2.7/tarfile.py", line 2051, in extractall
    self.extract(tarinfo, path)
  File "/usr/lib/python2.7/tarfile.py", line 2088, in extract
    self._extract_member(tarinfo, os.path.join(path, tarinfo.name))
  File "/usr/lib/python2.7/tarfile.py", line 2170, in _extract_member
    self.makedev(tarinfo, targetpath)
  File "/usr/lib/python2.7/tarfile.py", line 2238, in makedev
    os.makedev(tarinfo.devmajor, tarinfo.devminor))
OSError: [Errno 1] Operation not permitted
```

##### Agent Log
```text
Starting agent on port 49153
198.54.107.173:60064 connected
CMD: get_filesystem -z
EXEC: tar -C / --exclude=sys --exclude=proc --exclude=dev --exclude=mnt --exclude=run/docker --exclude=var/run/docker --exclude=var/lib/docker --exclude=var/lib/lxcfs --exclude=var/lib/vm2docker -c . -z -f filesystem.tar.gz


tar: ./var/lib/lxd/unix.socket: socket ignored
tar: ./run/docker.sock: socket ignored
tar: ./run/containerd/containerd.sock: socket ignored
tar: ./run/containerd/containerd.sock.ttrpc: socket ignored
tar: ./run/dbus/system_bus_socket: socket ignored
tar: ./run/uuidd/request: socket ignored
tar: ./run/snapd-snap.socket: socket ignored
tar: ./run/snapd.socket: socket ignored
tar: ./run/acpid.socket: socket ignored
tar: ./run/user/1000/snapd-session-agent.socket: socket ignored
tar: ./run/user/1000/systemd/private: socket ignored
tar: ./run/user/1000/systemd/notify: socket ignored
tar: ./run/user/1000/gnupg/S.gpg-agent: socket ignored
tar: ./run/user/1000/gnupg/S.gpg-agent.ssh: socket ignored
tar: ./run/user/1000/gnupg/S.gpg-agent.extra: socket ignored
tar: ./run/user/1000/gnupg/S.gpg-agent.browser: socket ignored
tar: ./run/user/1000/gnupg/S.dirmngr: socket ignored
tar: ./run/lvm/lvmpolld.socket: socket ignored
tar: ./run/lvm/lvmetad.socket: socket ignored
tar: ./run/systemd/journal/syslog: socket ignored
tar: ./run/systemd/journal/socket: socket ignored
tar: ./run/systemd/journal/stdout: socket ignored
tar: ./run/systemd/journal/dev-log: socket ignored
tar: ./run/systemd/private: socket ignored
tar: ./run/systemd/notify: socket ignored
tar: ./run/systemd/inaccessible/sock: socket ignored
tar: ./run/udev/control: socket ignored

Writing to Socket: Size: 960682966, Filename: filesystem.tar.gz
```

#### Issues
- Internal server kept crashing
- Decided that fixing that was not in scope and should move on to AWS EC2.


##### [Back-to-Index](../../../00-Index.md)