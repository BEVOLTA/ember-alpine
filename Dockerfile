FROM java:8
MAINTAINER Earvin Kayonga <e.kayonga@bevolta.com>

ENV EMBER_CLI_VERSION 2.4.1
ENV BOWER_VERSION 1.7.1
ENV PHANTOMJS_VERSION 1.9.7
ENV WATCHMAN_VERSION 3.5.0
ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.12

ENV LANG en_US.utf8

ADD install.sh .
RUN chmod +x install.sh && ./install.sh

# Set up user jenkins
RUN useradd -m -s /bin/bash jenkins
RUN echo jenkins:jenkins | chpasswd
RUN mkdir -p /var/run/sshd

EXPOSE 22
CMD /usr/sbin/sshd -D
