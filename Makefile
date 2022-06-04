.DEFAULT_GOAL := help

ifeq (run,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

run:
	@docker-compose run --rm --service-ports react-app sh -c "npm run $(RUN_ARGS)"

docker-build:
	@docker-compose down -v
	@docker-compose build

help:
	@echo "this is helpful"