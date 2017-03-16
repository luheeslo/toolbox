build_pebblecoind_base__alone:
	docker-compose build --force-rm _layer_pebblecoind_base

build_test_pebblecoind_data__alone:
	docker-compose build --force-rm _layer_test_pebblecoind_data

build_test_pebblecoind_conf_node__alone:
	docker-compose build --force-rm _layer_test_pebblecoind_conf_node

build_test_check_pebblecoind_ready__alone:
	docker-compose build --force-rm _layer_check_pebblecoind_ready

rebuild_daemon: stop_testnet \
        build_pebblecoind_base__alone \
        build_test_pebblecoind_data__alone \
		build_test_pebblecoind_conf_node__alone \
		build_test_check_pebblecoind_ready__alone \
		start_testnet

start_testnet:
	# start testnet if it isn't already started
	docker-compose up -d pebblecoind_1 pebblecoind_2

stop_testnet:
	# stop the testnet
	docker-compose stop -t 0 pebblecoind_1 pebblecoind_2
	docker-compose rm -f pebblecoind_1 pebblecoind_2

wait_for_testnet:
	# wait for testnet to compe up
	until docker-compose run --rm check_pebblecoind1_up > /dev/null; do \
	    echo "Waiting for pebblecoind1 to come up..."; \
	done
	until docker-compose run --rm check_pebblecoind2_up > /dev/null; do \
	    echo "Waiting for pebblecoind2 to come up..."; \
	done

restart_testnet:
	$(MAKE) stop_testnet
	$(MAKE) start_testnet
