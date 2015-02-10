FROM hpess/chef:latest
MAINTAINER Paul Cooke <paul.cooke@hp.com>

RUN curl -O http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.7.tgz && \  
tar -zxvf mongodb-linux-x86_64-2.6.7.tgz && \
mkdir -p /opt/mongodb  && \
cp -R -n mongodb-linux-x86_64-2.6.7/ /opt/mongodb  && \
mkdir -p /storage/mongo

ENV PATH="/opt/mongodb/mongodb-linux-x86_64-2.6.7/bin:$PATH"
COPY services/* /etc/supervisord.d/

# Expose ports.
#   - 27017: process
#   - 28017: http
EXPOSE 27017
EXPOSE 28017
