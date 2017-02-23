FROM mdillon/postgis:9.6

LABEL maintainer="Joao Paulo Dubas <joao.dubas@gmail.com>" \
      description="postgresql with postgis and temporal_tables extensions enabled" \
      version="2017.02.1"

RUN apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install postgresql-server-dev-9.6 python-pip \
    && pip install pgxnclient \
    && pgxn install --testing temporal_tables \
    && pip uninstall -y pgxnclient \
    && apt-get -y -qq --force-yes purge postgresql-server-dev-9.6 python-pip \
    && apt-get -y -qq --force-yes autoremove

COPY ./initdb-temporal-tables.sh /docker-entrypoint-initdb.d/temporal_tables.sh
