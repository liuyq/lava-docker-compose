all:
	docker-compose pull
	docker-compose build
	docker-compose up

lava-server:
	docker-compose build lava-server
	docker-compose up lava-server

lava-dispatcher:
	docker-compose build lava-dispatcher
	docker-compose up lava-dispatcher

clean:
	docker-compose rm -vsf
	docker volume rm -f lava-server-pgdata lava-server-joboutput lava-server-device-types lava-server-devices lava-server-health-checks lava-server-worker-state lava-server-worker-http lava-server-worker-tftp

create-admin:
	@echo -n "Input password for the LAVA 'admin' user to be created: "; \
	read passwd; \
	test -n "$$passwd" && docker-compose exec lava-server lava-server manage users add "admin" --superuser --staff --passwd $$passwd

.PHONY: all dispatcher clean create-admin
