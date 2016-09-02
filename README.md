# Elasticsearch
## With Kubernetes Discovery

This repo holds the configuration we use to run elasticsearch on kubernetes at reevoo.


## Support

The configuration contained in this repo is used internaly at reevoo. YMMV.

## WARNING

We have not yet implimented proper health checking on the master and data nodes.

It is possible to loose all the data in the cluster quite easily by updating a master 
or data deployment as the nodes are replaced faster than the time taken for
elasticsearch to start and for the new node to join the cluster.

We have mitigated this somewhat in the case of the master nodes by setting
`spec.minReadySeconds` to 60. This seems to work, but bear in mind that
updating the master deployment, is potentialy very distructive.

When upgrading the data nodes it seems to be a good idea to create a second
deployment, and then manulay scale each deployment up and down - waiting
for the shards to be reallocated until the upgrade is complete.

## Credit

This configuration is/was largely based on:

* (pires/kubernetes-elasticsearch-cluster)[https://github.com/pires/kubernetes-elasticsearch-cluster]
* (pires/docker-elasticsearch-kubernetes)[https://github.com/pires/docker-elasticsearch-kubernetes]
