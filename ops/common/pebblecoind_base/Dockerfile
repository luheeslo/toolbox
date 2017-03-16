FROM ubuntu:14.04

ADD http://8.26.21.56:10678/pebblecoind-dev /daemon/bin/pebblecoind
RUN chmod +x /daemon/bin/pebblecoind

ADD wait_and_get_link_ip.sh /daemon/bin/wait_and_get_link_ip.sh
RUN chmod +x /daemon/bin/wait_and_get_link_ip.sh

ADD entrypoint.sh /daemon/bin/entrypoint.sh
RUN chmod +x /daemon/bin/entrypoint.sh

CMD /daemon/bin/entrypoint.sh
