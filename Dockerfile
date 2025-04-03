FROM ubuntu
RUN apt-get update && apt-get -y install build-essential zip unzip 

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  systemd systemd-sysv dbus dbus-user-session

## it is possible to run with systemd if we include this AND use the --privileged flag at runtime: 

#COPY docker-entrypoint.sh /
#RUN chmod +x docker-entrypoint.sh
#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["service", "xagt", "start"]

WORKDIR /opt/hx_agent

# Make sure you put a copy of the Linux .zip file in the same folder for this to work:
COPY HX_AGENT_LINUX_DOCS_36.30.0.zip hx_agent.zip
RUN unzip hx_agent.zip && tar xvzf IMAGE_*.tgz
RUN dpkg -i xagt_36.30.0-1.ubuntu16_amd64.deb 
RUN /opt/fireeye/bin/xagt -i agent_config.json

ENV PATH=/opt/fireeye/bin:$PATH

## Recommended use:
# docker build -t xg_agent .
# docker run --rm -ti --init xg_agent bash

## Then in the container run daemon and view logs:
# xagt -M DAEMON
# xagt -G 

## verify task is running:
# ps -fA

