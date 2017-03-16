FROM ubuntu:14.04

ADD wait_and_get_link_ip.sh /daemon/bin/wait_and_get_link_ip.sh
RUN chmod +x /daemon/bin/wait_and_get_link_ip.sh

ADD entrypoint.sh /daemon/bin/entrypoint.sh
RUN chmod +x /daemon/bin/entrypoint.sh

ADD ./pebblecoind.gz /tmp
RUN gzip -d /tmp/pebblecoind.gz \
    && cp /tmp/pebblecoind /daemon/bin/pebblecoind \
    && rm /tmp/* \
    && chmod +x /daemon/bin/pebblecoind

CMD /daemon/bin/entrypoint.sh
