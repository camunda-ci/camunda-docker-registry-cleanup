FROM jfloff/alpine-python:3.4

ENV REGISTRY_DATA_DIR=/registry

RUN apk add --update curl \
    && rm /var/cache/apk/*

RUN curl https://raw.githubusercontent.com/burnettk/delete-docker-registry-image/master/delete_docker_registry_image.py | \
    tee /usr/local/bin/delete_docker_registry_image >/dev/null && \
    chmod +x /usr/local/bin/delete_docker_registry_image

ENTRYPOINT ["/usr/local/bin/delete_docker_registry_image", "--verbose", "--image"]