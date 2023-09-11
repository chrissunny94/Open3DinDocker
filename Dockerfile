FROM nvidia/cudagl:10.2-devel
RUN apt update && apt install -y sudo x11-apps mesa-utils git python3 python3-pip
RUN mkdir -p /home/$USER/ # This is only required inside VS Code

RUN pip3 install --upgrade pip
RUN pip3 install open3d 
#RUN echo -e "yourpassword\nyourpassword" | passwd chris

RUN adduser --disabled-password \
--gecos '' docker

#  Add new user docker to sudo group
RUN adduser docker sudo

# Ensure sudo group users are not 
# asked for a password when using 
# sudo command by ammending sudoers file
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> \
/etc/sudoers

# now we can set USER to the 
# user we just created
USER docker

# we can now run sudo commands 
# as non-root user `docker` without
# password prompt
RUN sudo apt-get update 

WORKDIR /home/docker/src
CMD ["/bin/bash"]
