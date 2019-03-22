#base image is needed
FROM ubuntu:latest
MAINTAINER jyotismita1989

RUN apt-get update
RUN apt-get install -y python python-pip wget
RUN pip install Django


RUN apt-get update -y && \
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

#RUN echo "JAVA_HOME=/usr">> .bashrc

# Define working directory.
#WORKDIR /home

# Define default command.
#CMD ["bash"]
#RUN executed at the time of building the image

ADD http://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.17/bin/apache-tomcat-9.0.17.tar.gz /tmp
RUN cd /tmp && tar -xvzf apache-tomcat-9.0.17.tar.gz
RUN cd /tmp && mv apache-tomcat-9.0.17 /opt/
EXPOSE 8080

ADD https://updates.jenkins-ci.org/download/war/2.168/jenkins.war /opt/apache-tomcat-9.0.17/webapps/

#CMD runs while creation of container
CMD ["/opt/apache-tomcat-9.0.17/bin/catalina.sh", "run"]
