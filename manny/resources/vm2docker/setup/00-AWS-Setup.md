# AWS VM Setup

## Specifications
- Type: *t2.large*
- EBS Volume Size: *200GB*
- OS: Ubuntu
- UserData (Chief):
```bash
#!/bin/bash
sudo apt-get update 
sudo apt-get install -y python python-pip python-dev swig
sudo apt-get install -y rsync curl duplicity docker.io
sudo apt-get install -y libpcap-dev libarchive-dev
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ubuntu 
sudo mkdir -p /var/lib/vm2docker/tmp
sudo chown -R ubuntu /var/lib/vm2docker
sudo chgrp -R ubuntu /var/lib/vm2docker
cd /var/lib/vm2docker
git clone https://github.com/Manny2014/vm2docker.git
cd vm2docker/agent
make
sudo ./agent
```
- Post Provisiong Manual Steps:
    - Update Docker daemong to use *tcp* instead of *unix socket*
        1. File: /lib/systemd/system/docker.service
        ```bash
        [Service]
        Type=notify
        #ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
        ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375
        ```
        2. Bounce dockerd
        ```bash
        systemctl daemon-reload
        systemctl restart docker
        ```

##### [Back-to-Index](../../../00-Index.md)