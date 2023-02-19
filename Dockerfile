FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y python3 python3-pip
WORKDIR /app

COPY requirements.txt /app

RUN pip3 install -r requirements.txt

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar /usr/share/jenkins/agent.jar -jnlpUrl http://52.33.25.135:8080/computer/my_python_agent/slave-agent.jnlp -workDir ${AGENT_WORKDIR}"]
