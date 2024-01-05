from ubuntu:22.04

RUN apt update && apt upgrade -y

RUN apt install -y \
    openjdk-17-jre \
    openjdk-17-jre-headless \
    nano \
    ffmpeg \
    vlc \
    curl \
    wget \
    gnupg2 \
    sox

WORKDIR /opt

RUN wget https://archive.apache.org/dist/openmeetings/7.2.0/bin/apache-openmeetings-7.2.0.tar.gz && \
    tar -xzvf apache-openmeetings-7.2.0.tar.gz 

RUN mv apache-openmeetings-7.2.0 open720 && rm apache-openmeetings-7.2.0.tar.gz

RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar   && \ 
    cp /opt/mysql-connector-java-8.0.30.jar /opt/open720/webapps/openmeetings/WEB-INF/lib 

RUN wget https://cwiki.apache.org/confluence/download/attachments/27838216/tomcat34 && \
    mv tomcat34 /etc/init.d && \
    chmod +x /etc/init.d/tomcat34

RUN apt-get purge -y --auto-remove 
RUN chown -R nobody:nogroup /opt/open720

EXPOSE 5443

RUN /etc/init.d/tomcat34 start 

ENTRYPOINT ["tail","-f","open720/logs/catalina.out"]

