Camunda Docker Registry Cleanup
===============================

Usage
-----

**Before you start using this container, stop your docker registry.**

Examples
--------

The variable `$DOCKER_REGISTRY_PATH` in these examples is your actual Docker Registry path like eg. `$HOME/volumes/docker-registry/docker/registry/v2`

Showing all untagged images of a repository: 
```
docker run -t --rm -v $DOCKER_REGISTRY_PATH:/registry registry.camunda.com/camunda-docker-registry-cleanup my_image --untagged --dry-run 
```

Deleting all untagged images of a repository: 
```
docker run -t --rm -v $DOCKER_REGISTRY_PATH:/registry registry.camunda.com/camunda-docker-registry-cleanup my_image --untagged 
```

Delete an image tag of a repository: 
```
docker run -t --rm -v $DOCKER_REGISTRY_PATH:/registry registry.camunda.com/camunda-docker-registry-cleanup my_image:my_tag 
```

Parameters
==========

```
-h, --help      - Show parameters
-n, --dry-run   - Just show what would be deleted when command is executed
-p, --prune     - Delete all empty directories
-u, --untagged  - Delete all untagged images for the given repository
```
