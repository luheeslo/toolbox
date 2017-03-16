# Container which returns success if the given node is up, fails otherwise
# Defaults to checking node 'pebblecoind'

FROM ubuntu:14.04

RUN sudo apt-get update && sudo apt-get install -y curl

ADD check_node_up.sh /check_node_up.sh
RUN chmod +x /check_node_up.sh

ENTRYPOINT ["/check_node_up.sh", "pebblecoind"]
