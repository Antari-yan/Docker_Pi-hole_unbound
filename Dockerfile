FROM pihole/pihole:latest

RUN apt update && apt install -y --no-install-recommends \
    unbound

RUN curl -s https://www.internic.net/domain/named.root | sudo tee /var/lib/unbound/root.hints > /dev/null
RUN touch /var/log/unbound.log
RUN chown unbound:unbound /var/lib/unbound/root.hints /var/log/unbound.log

#RUN touch /var/lib/unbound/root.key
# https://www.nlnetlabs.nl/documentation/unbound/howto-anchor/
# https://data.iana.org/root-anchors/root-anchors.xml
RUN echo ". IN DS 19036 8 2 49AAC11D7B6F6446702E54A1607371607A1A41855200FD2CE1CDDE32F24E8FB5" > /var/lib/unbound/root.key
RUN echo ". IN DS 20326 8 2 E06D44B80B8F1D39A95C0B0D7C65D08458E880409BBC683457104237C7F8EC8D" > /var/lib/unbound/root.key

RUN /etc/init.d/unbound stop
#RUN /etc/init.d/unbound start
#RUN /etc/init.d/unbound restart
#RUN unbound
#RUN unbound -c /etc/unbound/unbound.conf

ENTRYPOINT unbound && ./s6-init

# https://docs.pi-hole.net/guides/dns/unbound/
# https://github.com/pi-hole/docker-pi-hole/#note-on-watchtower
