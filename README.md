# Docker Pi-hole & unbound
This is a small example for running Pi-hole with unbound as recursive DNS as a single containerized service using [docker](https://docs.docker.com/).

## Usage
Create a `.env` file in this directory containing:
``` properties
# Required:
PIHOLE_WEBPASSWORD=securepassword

# Optional:
PIHOLE_TZ=Europe/Berlin
```

Start the container:
``` bash
docker compose down && docker compose up -d --build
```

The Pi-hole WebUI should be available under http://localhost:80/admin.

Check if everything works in the container:
``` bash
docker exec -it pihole bash
/etc/init.d/unbound status
dig pi-hole.net @127.0.0.1 -p 5335
dig dnssec.works @127.0.0.1 -p 5335
cat /var/log/unbound.log
```

## References
- [Official Pi-hole Doku](https://docs.pi-hole.net/)
- [Official Docker Pi-hole Git](https://github.com/pi-hole/docker-pi-hole/)
