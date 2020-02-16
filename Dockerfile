FROM alpine:3.11.3

ENV AWSCLI_VERSION "1.18.0"
ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    pip3 install --no-cache --upgrade pip setuptools wheel awscli==${AWSCLI_VERSION}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
