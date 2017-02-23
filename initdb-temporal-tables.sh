#!/bin/sh
set -e

export PGUSER="$POSTGRES_USER"

echo "Loading temporal-tables extension"
for DB in template_postgis "$POSTGRES_DB"; do
	"${psql[@]}" --dbname="$DB" <<- 'EOSQL'
		CREATE EXTENSION IF NOT EXISTS temporal_tables;
	EOSQL
done
