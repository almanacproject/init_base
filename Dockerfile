FROM alpine:3.3

MAINTAINER Raphael Ahrens

VOLUME ["/opt/volumes/", "/opt/input"]

RUN apk update && apk add python3 git openssl openjdk8-jre

RUN python3 -m ensurepip && pip3 install --upgrade pip setuptools

RUN pip install git+https://github.com/almanacproject/rework.git@v0.1
RUN pip install git+https://github.com/almanacproject/psst.git@v0.1
RUN pip install git+https://github.com/almanacproject/bob_cert_builder.git@v0.1
