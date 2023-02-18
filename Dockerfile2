FROM python:3.9-slim-buster

# Install required dependencies
RUN apt-get update \
    && apt-get install -y git \
    && apt-get clean

# Install Jenkins agent JAR file
ARG AGENT_VERSION=4.10
ARG AGENT_WORKDIR=/home/jenkins/agent
RUN mkdir -p ${AGENT_WORKDIR}
RUN curl --create-dirs -sSLo /usr/share/jenkins/agent.jar \
      https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${AGENT_VERSION}/remoting-${AGENT_VERSION}.jar \
    && chmod 755 /usr/share/jenkins \
    && chmod 644 /usr/share/jenkins/agent.jar

# Set up Jenkins agent
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN useradd -d ${AGENT_WORKDIR} -u 1000 -m -s /bin/bash jenkins
RUN mkdir /app
RUN chown -R jenkins:jenkins ${AGENT_WORKDIR} /app

# Set up Python environment
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Start the agent
USER jenkins
ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/agent.jar"]



