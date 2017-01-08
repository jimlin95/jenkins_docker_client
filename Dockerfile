FROM ubuntu:14.04.5
MAINTAINER Jim Lin <jim_lin@quantatw.com>


#ADD apt.conf /etc/apt/ 
ADD .gitconfig /root/
RUN apt-get update -qq


RUN apt-get install -y build-essential git-core 


# Install a basic SSH server
RUN apt-get install -y --no-install-recommends openssh-server openjdk-7-jre-headless
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Clean up
RUN apt-get -y --purge remove wget && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/cache/apt/*

# Add user jenkins to the image
RUN adduser --quiet jenkins 
RUN adduser jenkins sudo
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

USER jenkins
# Add files for development environment
RUN mkdir -p /home/jenkins/.ssh
ADD .gitconfig /home/jenkins/
ADD .bashrc /home/jenkins/
ADD .profile /home/jenkins/
USER root

# Standard SSH port
EXPOSE 22
#
CMD ["/usr/sbin/sshd", "-D"]
#  
