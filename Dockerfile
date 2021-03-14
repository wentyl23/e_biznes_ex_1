FROM ubuntu:18.04

#JAVA
RUN apt update && apt install -y openjdk-8-jdk && \
	apt-get clean;

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

#UTILITY
RUN apt update && apt install -y \
	unzip \
	vim \
	git \
	wget \
	curl 

#SCALA
RUN wget https://downloads.lightbend.com/scala/2.12.13/scala-2.12.13.deb && \
	dpkg -i scala-2.12.13.deb


#NODE & NPM
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
	apt update && apt install -y nodejs && \
	npm install npm@latest -g
	
#SBT 
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && \
	apt update && apt install sbt -y


#react port
EXPOSE 3000
#play port
EXPOSE 9000


RUN useradd -ms /bin/bash mmentel
RUN adduser mmentel sudo

USER mmentel
WORKDIR /home/mmentel/
RUN mkdir /home/mmentel/shared

VOLUME ["/home/mmentel/shared"]

