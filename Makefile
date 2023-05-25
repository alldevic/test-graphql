#!/usr/bin/make
.PHONY: up down logs

SHELL = /bin/bash
CURRENT_UID := $(shell id -u):$(shell id -g)

export CURRENT_UID


up:
	docker compose up -d --force-recreate --build --remove-orphans

down:
	docker compose down

logs:
	docker compose logs -f