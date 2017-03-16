# local testnet which has entry point which wait_and_get_link_ip.sh on the given
# node and adds it as an exclusive node

FROM test_pebblecoind_data

COPY pebblecoin.conf /daemon/data/pebblecoin.conf

ADD wait_add_node_and_run_daemon.sh /daemon/bin/wait_add_node_and_run_daemon.sh
RUN chmod +x /daemon/bin/wait_add_node_and_run_daemon.sh

ENTRYPOINT ["/daemon/bin/wait_add_node_and_run_daemon.sh"]

# the node to connect to will be specified in the docker-compose files
