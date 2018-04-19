FROM devhub-docker.cisco.com/iox-docker/ie4k/base-rootfs

ADD agent start_agent.sh /usr/local/bin/
 
RUN opkg update && \
    opkg install libstdc++ && \
    mkdir /data

EXPOSE 5000
CMD ["/bin/sh", "/usr/local/bin/start_agent.sh"]
