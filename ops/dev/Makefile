DOCKER_COMPOSE=docker-compose \
	    -f ../pypebblecoin-testing/ops/docker-compose.yml \
	    -f docker-compose.yml
MAKE_PYPTESTING=$(MAKE) -C ../pypebblecoin-testing/ops


build_app:
	$(DOCKER_COMPOSE) build --no-cache _layer_xpbwalletman_app

build_appbase:
	$(DOCKER_COMPOSE) build --no-cache _layer_xpbwalletman_appbase

build_repobase:
	$(DOCKER_COMPOSE) build --no-cache _layer_xpbwalletman_repobase

build_app_server:
	$(MAKE) build_repobase
	$(MAKE) build_appbase
	$(MAKE) build_app

start_elk:
	$(DOCKER_COMPOSE) up -d test_elasticsearch test_logstash test_kibana

stop_elk:
	$(DOCKER_COMPOSE) stop test_elasticsearch test_logstash test_kibana

start_mongo:
	# start mongodb if it isn't already started
	$(DOCKER_COMPOSE) up -d mongodb

stop_mongo:
	# stop the database
	$(DOCKER_COMPOSE) stop -t 0 mongodb
	$(DOCKER_COMPOSE) rm -f mongodb

start_mongo_test:
	# start mongodb if it isn't already started
	$(DOCKER_COMPOSE) up -d mongodb_test

stop_mongo_test:
	# stop the database
	$(DOCKER_COMPOSE) stop -t 0 mongodb_test
	$(DOCKER_COMPOSE) rm -f mongodb_test

wait_for_mongo:
	# wait for test db to come up
	until $(DOCKER_COMPOSE) run --rm check_mongodb_up > /dev/null; do \
	    echo "Waiting for db to come up..."; \
	done

wait_for_mongo_test:
	# wait for test db to come up
	until $(DOCKER_COMPOSE) run --rm check_mongodb_up_test > /dev/null; do \
	    echo "Waiting for db to come up..."; \
	done

start_flower:
	$(DOCKER_COMPOSE) up celery_flower

start_backend:
	$(MAKE) start_mongo
	$(MAKE_PYPTESTING) start_testnet

stop_backend:
	$(MAKE) stop_mongo
	$(MAKE_PYPTESTING) stop_testnet

wait_for_backend:
	$(MAKE) wait_for_mongo
	$(MAKE_PYPTESTING) wait_for_testnet

start_backend_test:
	$(MAKE) start_mongo_test
	$(MAKE_PYPTESTING) start_testnet

stop_backend_test:
	$(MAKE) stop_mongo_test
	$(MAKE_PYPTESTING) stop_testnet

wait_for_backend_test:
	$(MAKE) wait_for_mongo_test
	$(MAKE_PYPTESTING) wait_for_testnet

start_app_server:
	$(DOCKER_COMPOSE) up celery_beat celery_worker_default celery_worker_daemon celery_worker_log celery_worker_account_tx_effects dev_app_server

stop_app_server:
	# stop all but database/testnet
	$(DOCKER_COMPOSE) stop -t 0 redis celery_worker_default celery_worker_daemon celery_worker_log celery_worker_account_tx_effects dev_app_server
	$(DOCKER_COMPOSE) rm -f redis celery_worker_default celery_worker_daemon celery_worker_log celery_worker_account_tx_effects dev_app_server

# run_app_server:
# 	# start db first
# 	$(MAKE) start_backend
# 	# restart testnet
# 	$(MAKE_PYPTESTING) restart_testnet
# 	$(MAKE) start_elk
# 	# stop & rebuild tests
# 	# $(MAKE) build_app
# 	$(MAKE) wait_for_backend
# 	$(MAKE) start_app_server

run_app_server:
	#$(DOCKER_COMPOSE) up -d mongodb redis test_elasticsearch test_logstash test_kibana
	$(DOCKER_COMPOSE) up -d mongodb redis 
	$(MAKE_PYPTESTING) restart_testnet
	$(MAKE) wait_for_backend
	$(DOCKER_COMPOSE) up -d dev_app_server celery_worker_default celery_worker_log celery_worker_account_tx_effects celery_worker_daemon celery_beat

# run_tests:
# 	$(MAKE) start_elk
# 	# start mongo & testnet
# 	$(MAKE) start_backend_test
# 	# restart testnet
# 	$(MAKE_PYPTESTING) restart_testnet
# 	# stop & rebuild tests
# 	$(MAKE) stop_tests
# 	# $(MAKE) build_app
# 	$(MAKE) wait_for_backend_test

# 	# run tests
# 	$(DOCKER_COMPOSE) run --rm test py.test $(LOG) --cov-report term-missing --cov=xpbwalletman $(TEST_ARGS)

run_tests:
	$(DOCKER_COMPOSE) up -d mongodb_test redis test_elasticsearch test_logstash test_kibana
	$(MAKE_PYPTESTING) restart_testnet
	$(MAKE) wait_for_backend_test
	$(DOCKER_COMPOSE) run --rm test py.test $(LOG) --cov-report term-missing --cov=xpbwalletman $(TEST_ARGS)

run_fast_tests:
	$(MAKE) TEST_ARGS="--skipslow" run_tests

stop_tests:
	# stop all but database/testnet
	$(DOCKER_COMPOSE) stop -t 0 redis celery_worker_test test
	$(DOCKER_COMPOSE) rm -f redis celery_worker_test test

stop_all_containers:
	$(DOCKER_COMPOSE) stop dev_app_server celery_worker_default celery_worker_log celery_worker_account_tx_effects celery_worker_daemon celery_beat
	#$(DOCKER_COMPOSE) stop redis test_elasticsearch test_logstash test_kibana
	$(DOCKER_COMPOSE) stop redis	
	$(MAKE_PYPTESTING) stop_testnet
	$(DOCKER_COMPOSE) stop mongodb mongodb_test
	$(MAKE) stop_tests
