#base image is needed
FROM ubuntu:latest
MAINTAINER jyotismita1989

RUN apt-get update
RUN apt-get install -y python python-pip wget
RUN pip install Django

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Define working directory.
#WORKDIR /home

# Define default command.
#CMD ["bash"]


