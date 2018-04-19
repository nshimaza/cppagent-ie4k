FROM devhub-docker.cisco.com/iox-docker/ie4k/base-rootfs
 
RUN opkg update && \
    opkg install iox-toolchain && \
    opkg install libxml2-dev && \
    opkg install cppunit-dev && \
    opkg install cmake && \
    opkg install pkgconfig
ADD copy.sh /
ADD https://github.com/mtconnect/cppagent/archive/v1.4.0.10.tar.gz /opt/src/
RUN cd /opt/src && \
    tar zxf v1.4.0.10.tar.gz && \
    mv cppagent-1.4.0.10 cppagent && \
    cd cppagent && \
    cmake . && \
    make agent
