FROM ubuntu:14.04
RUN apt-get update && \
apt-get install -y python python-pip python-dev swig && \
apt-get install -y rsync curl duplicity docker.io

#RUN apt-get install -y gdb # (for debugging)

# add sourcecode
ADD . /src/
RUN pip install -r /src/chief/requirements.txt

WORKDIR /src/chief
RUN make clean
RUN make
RUN chmod +x vm2docker.py

ENTRYPOINT ["./vm2docker.py"]

#ENV DOCKER_HOST tcp://10.10.1.10:2375
# TODO: experiment with ONBUILD to add code after the fact