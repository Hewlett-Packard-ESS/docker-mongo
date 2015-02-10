FROM hpess/chef:latest
MAINTAINER Paul Cooke <paul.cooke@hp.com>
 
RUN curl -s -O http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.7.tgz && \  
tar -zxvf mongodb-linux-x86_64-2.6.7.tgz && \
rm *.tgz && \
mv mongodb-linux* /opt/mongodb && \
mkdir -p /storage/mongo

ENV PATH="/opt/mongodb/bin:$PATH"
COPY services/* /etc/supervisord.d/

# Add our preboot scripts
COPY preboot/* /preboot/

# Expose ports.
#   - 27017: process
#   - 28017: http
EXPOSE 27017 28017
