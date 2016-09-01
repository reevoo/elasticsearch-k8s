#!/bin/sh

# provision elasticsearch user
chown -R elasticsearch /elasticsearch /data

# allow for memlock
ulimit -l unlimited

# drop permissions
su-exec elasticsearch /elasticsearch/bin/elasticsearch
