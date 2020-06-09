# SETUP 

## Dockerfile Modifications
```diff 
diff --git a/Dockerfile b/Dockerfile
index f67030f..12aff65 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,9 +1,8 @@
 FROM ubuntu:14.04
-RUN apt-get update
-RUN apt-get install -y python python-pip python-dev swig
-RUN apt-get install -y rsync curl duplicity
-RUN curl -s https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker
-RUN chmod +x /usr/local/bin/docker
+RUN apt-get update && \
+apt-get install -y python python-pip python-dev swig && \
+apt-get install -y rsync curl duplicity docker.io
+
 #RUN apt-get install -y gdb # (for debugging)
 
 # add sourcecode
 ```

## Docker installation on Ubuntu Host 
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
sudo mkdir -p /var/lib/vm2docker/
sudo chown -R ubuntu /var/lib/vm2docker
sudo chgrp -R ubuntu /var/lib/vm2docker
cd /var/lib/vm2docker
git clone https://github.com/Manny2014/vm2docker.git
```

## Docker TCP Configuration
- Change Dockerd start script to use tcp://0.0.0.0:2375
    - File: /lib/systemd/system/docker.service
```bash
[Service]
Type=notify
#ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375
```
- Bounce dockerd

```bash
systemctl daemon-reload
systemctl restart docker
```