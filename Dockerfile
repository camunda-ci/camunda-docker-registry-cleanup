FROM alpine:latest

ENV REGISTRY_DATA_DIR=/registry

RUN apk --no-cache add python3

ADD https://raw.githubusercontent.com/burnettk/delete-docker-registry-image/master/delete_docker_registry_image.py /usr/local/bin/delete_docker_registry_image

ENTRYPOINT ["python3", "/usr/local/bin/delete_docker_registry_image", "--verbose", "--image"]
