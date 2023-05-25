#!/usr/bin/make
.PHONY: up down logs volumes clean

SHELL = /bin/bash
CURRENT_UID := $(shell id -u):$(shell id -g)
MAIN_COMPOSE=docker-compose.yml
PGADMIN_COMPOSE=./tools/pgadmin4/pgadmin4.docker-compose.yml
COMPOSES=-f $(MAIN_COMPOSE) -f $(PGADMIN_COMPOSE)

define SERVERS_JSON
{
	"Servers": {
		"1": {
			"Name": "Database",
			"Group": "Servers",
			"Host": "172.16.0.10",
			"Port": 5432,
			"MaintenanceDB": "TESTDB",
			"Username": "GRAPH",
			"SSLMode": "prefer",
			"PassFile": "/tmp/pgpassfile"
		}
	}
}
endef 

export PGPASS
export SERVERS_JSON
export CURRENT_UID
export COMPOSES
export MAIN_COMPOSE
export PGADMIN_COMPOSE

volumes:
	docker volume create test-graphql-db
	docker volume create test-graphql-pgadmin
up: volumes
	docker compose up -d --force-recreate --build --remove-orphans

down:
	docker compose down

logs:
	docker compose logs -f

clean:
	docker volume rm test-graphql-db -f
	docker volume rm test-graphql-pgadmin -f
pgadmin4:
	rm -f ./tools/pgadmin4/servers.json
	echo "$$SERVERS_JSON" > ./tools/pgadmin4/servers.json
	docker volume create test-graphql-db
	docker volume create test-graphql-pgadmin
	docker compose $(COMPOSES) up -d --build --remove-orphans pgadmin
	$(info PgAdmin4 http://localhost:15432)
down-pgadmin4:
	docker compose $(COMPOSES) rm -fsv pgadmin
clean-pgadmin4:
	rm -rf ./tools/pgadmin4/servers.json
	docker volume rm test-graphql-pgadmin