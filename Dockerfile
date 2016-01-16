# DOCKER-VERSION 1.0.1
# VERSION        1.0

FROM debian:jessie
MAINTAINER Swaraj Yadav <yadav.swaraj@gmail.com>

# Install php 5 and other required utilities
RUN apt-get update
RUN apt-get install -y php5-fpm php5-dev git wget vim net-tools
RUN /etc/init.d/php5-fpm start

# Install zeromq 4.1.4
RUN apt-get install -y libtool pkg-config build-essential autoconf automake uuid-dev libsodium13 libsodium-dev
# Uncomment to install e2fsprogs if not already installed
# RUN apt-get install e2fsprogs
RUN wget -q -O - http://download.zeromq.org/zeromq-4.1.4.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zeromq-4.1.4 /opt/zeromq
RUN cd /opt/zeromq && ./configure && make && make install
RUN ldconfig


# Install php binding
RUN cd /root && git clone git://github.com/mkoppanen/php-zmq.git
RUN cd /root/php-zmq && phpize && ./configure && make && make install
RUN cp /root/php-zmq/modules/zmq.so /usr/lib/php5/20131226/
RUN cd /etc/php5/fpm/conf.d/ && touch 20-zmq.ini && echo "extension=zmq.so" > 20-zmq.ini && cp 20-zmq.ini /etc/php5/cli/conf.d/
RUN /etc/init.d/php5-fpm restart

EXPOSE 5555

COPY client_runner.php /root/
COPY zeromq_client.php /root/
COPY zeromq_server.php /root/
COPY client_persistent_runner.php /root/	
COPY info.php /root/
COPY zeromq_persistent_client.php /root/

WORKDIR /root
