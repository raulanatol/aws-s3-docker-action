FROM alpine:3.11.3

ENV AWSCLI_VERSION "1.18.0"

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    && pip install awscli==${AWSCLI_VERSION} --quiet --no-cache-dir --upgrade --user \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
