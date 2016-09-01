FROM alpine:3.4
MAINTAINER devops@reevoo.com

ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre
ENV VERSION 1.5.2

RUN apk upgrade --no-cache

RUN apk add --no-cache \
    openjdk8-jre \
    su-exec \
    curl \
    ca-certificates \
  && ( curl -Lskj https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-$VERSION.tar.gz |  gunzip -c - | tar xf - ) \
  && mv /elasticsearch-$VERSION /elasticsearch \
  && rm -rf $(find /elasticsearch | egrep "(\.(exe|bat)$|sigar/.*(dll|winnt|x86-linux|solaris|ia64|freebsd|macosx))") \
  && apk del curl \
  && adduser -D -g '' elasticsearch

ADD do_not_use.yml /elasticsearch/config/elasticsearch.yml
RUN /elasticsearch/bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/1.2.1
RUN /elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/v1.6.1
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-aws/2.5.1
COPY config /elasticsearch/config

COPY es.sh /

# Set environment variables defaults
ENV ES_HEAP_SIZE 512m
ENV CLUSTER_NAME elasticsearch-default
ENV NODE_MASTER true
ENV NODE_DATA true
ENV HTTP_ENABLE true
ENV NETWORK_HOST _site_
ENV HTTP_CORS_ENABLE true
ENV HTTP_CORS_ALLOW_ORIGIN *
ENV NUMBER_OF_SHARDS 5
ENV NUMBER_OF_REPLICAS 1
ENV NAMESPACE default
ENV DISCOVERY_SERVICE elasticsearch-discovery
ENV MINIMUM_MASTER_NODES 1

CMD ["/es.sh"]
