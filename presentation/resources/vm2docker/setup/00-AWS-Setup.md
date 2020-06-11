# AWS VM Setup

## Specifications
- Type: *t2.large*
- EBS Volume Size: *200GB*
- OS: Ubuntu

- UserData:
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
```
- Post Provisiong Manual Steps:
    - Log into instance
    ```bash
    manny@Emmanuels-MBP:~$ ssh -i ~/.ssh/ec2.pem  ubuntu@34.239.179.18
    ```
    - Update Docker daemong to use *tcp* instead of *unix socket*
        1. File: /lib/systemd/system/docker.service
        ```bash
        # SETP # 1 OPEN SERVICE FILE
        sudo vi /lib/systemd/system/docker.service

        [Service]
        Type=notify
        # SETP # 2 COMMENT OUT THIS LINE
        #ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
        # SETP # 3 ADD THE LINE BELOW
        ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375
        ```
        2. Bounce dockerd
        ```bash
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        ```
        3. Run docker ps to verify
        ```bash
        ubuntu@ip-172-31-85-187:~$ docker ps
        CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
        ```
##### [Back-to-Index](../../../00-Index.md)
