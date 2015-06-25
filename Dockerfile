FROM hpess/chef:master
MAINTAINER Karl Stoney <karl.stoney@hp.com> 

RUN curl -s -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.0.4.tgz && \  
    tar -zxf mongodb-linux-*.tgz && \
    rm *.tgz && \
    mv mongodb-linux* /opt/mongodb && \
    chown -R docker:docker /opt/mongodb

RUN echo '* - nofile 64000' >> /etc/security/limits.conf && \
    echo '* - nproc 32000' >> /etc/security/limits.conf && \
    echo '* - nproc 32000' >> /etc/security/limits.d/90-nproc.conf

ENV PATH="/opt/mongodb/bin:$PATH"
ENV HPESS_ENV mongodb
ENV chef_node_name mongodb.docker.local
ENV chef_run_list mongodb

EXPOSE 27017 28017

COPY services/* /etc/supervisord.d/
COPY cookbooks/ /chef/cookbooks/
COPY preboot/* /preboot/
