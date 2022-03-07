FROM python:3.10.2-alpine3.15

ADD . /migrate

WORKDIR /migrate

RUN pip3 install --no-cache-dir . databricks-cli

ENTRYPOINT ["/bin/sh"]
