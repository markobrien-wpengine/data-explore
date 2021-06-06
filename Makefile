help: ## Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
}' $(MAKEFILE_LIST) | sort

build:
	docker-compose -f docker-compose.yml build

run:
	docker-compose -f docker-compose.yml up

run_as_daemon:
	docker-compose -f docker-compose.yml up -d

stop:
	docker-compose -f docker-compose.yml down

clean: stop ## Delete local data and ensure containers are stopped
	rm -rf ./docker/.compose-data

psql:
	docker-compose -f docker-compose.yml exec db psql rainbows_db -U usr