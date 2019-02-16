FROM mdillon/postgis:10

LABEL maintainer="Joao Paulo Dubas <joao.dubas@gmail.com>" \
      org.opencontainers.image.authors="Joao Paulo Dubas <joao.dubas@gmail.com>" \
      org.opencontainers.image.title="Postgres with support to temporal tables" \
      org.opencontainers.image.description="Postgres with postgis and temporal_tables extensions enabled" \
      org.opencontainers.image.url="https://github.com/joaodubas/temporal-table" \
      org.opencontainers.image.source="https://github.com/joaodubas/temporal-table" \
      org.opencontainers.image.documentation="https://github.com/joaodubas/temporal-table/blob/master/README.md" \
      org.opencontainers.image.licenses="MIT"

ENV SYS_PACKAGES="build-essential make postgresql-server-dev-10 python-setuptools python-pip"

RUN apt-get -y update \
    && apt-get -y install --no-install-recommends ${SYS_PACKAGES}\
    && pip install pgxnclient \
    && pgxn install --testing temporal_tables \
    && pip uninstall -y pgxnclient \
    && apt-get -y purge ${SYS_PACKAGES} \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

COPY ./initdb-temporal-tables.sh /docker-entrypoint-initdb.d/temporal_tables.sh

ARG CREATED
ARG REVISION
LABEL org.opencontainers.create=${CREATED} \
      org.opencontainers.version=${REVISION} \
      org.opencontainers.revision=${REVISION}
