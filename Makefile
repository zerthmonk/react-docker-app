.DEFAULT_GOAL := help

ifeq (run,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

run:  ## start service with argument passed to npm run (make run start | make run build)
	@docker-compose run --rm --service-ports react-app sh -c "npm run $(RUN_ARGS)"

docker-build:  ## rebuild docker image (no cache)
	@docker-compose down -v
	@docker-compose build --no-cache

help:
	@echo "\nblackshell make commands:\n"
	@grep -E '^[a-zA-Z.%_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | awk 'BEGIN {FS = ":.*?## "}; {printf "%2s$(ACCENT)%-20s${RESET} %s\n", " ", $$1, $$2}'
	@echo ""