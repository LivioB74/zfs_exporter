FROM docker.io/library/golang:buster

RUN echo "deb http://ftp.debian.org/debian buster-backports main contrib" >> /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get -y install -t buster-backports zfsutils-linux && \
    mkdir /opt/zfs_exporter

RUN curl -LO https://github.com/pdf/zfs_exporter/releases/download/v2.2.5/zfs_exporter-2.2.5.linux-amd64.tar.gz && \
    tar -zxf zfs_exporter-2.2.5.linux-amd64.tar.gz --strip-components=1 -C /opt/zfs_exporter && \
    ln -s /opt/zfs_exporter/zfs_exporter /usr/local/bin/zfs_exporter

CMD ["zfs_exporter --collector.dataset-snapshot"]