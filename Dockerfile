############################################################
# Dockerfile to build 
# Based on https://github.com/buchen/portfolio
FROM [user.id]/[parent.repository][parent.tag]

###########################################################
# File Author / Maintainer
MAINTAINER [user.name] "[user.email]"
################## BEGIN INSTALLATION ######################
USER root
RUN /bin/bash -c "apt-get update && apt-get upgrade -y && apt-get clean && apt-get autoremove"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install libwebkitgtk-1.0-0 libxtst6

#http://idroot.net/tutorials/how-to-install-eclipse-luna-on-ubuntu-14-04/
##http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
ADD eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz /opt
RUN ln -s /opt/eclipse/eclipse /usr/local/bin/
RUN mkdir -p /home/user && \
    echo "user:x:1000:1000:Default User,,,:/home/user:/bin/bash" >> /etc/passwd && \
    echo "user:x:1000:" >> /etc/group && \
    #echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user && \
    #chmod 0440 /etc/sudoers.d/user && \
    chown user:user -R /home/user

VOLUME /data
USER user
ENV HOME /home/user
WORKDIR /home/user
CMD /opt/eclipse/eclipse

