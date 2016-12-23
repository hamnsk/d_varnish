FROM debian:jessie

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y -q && \
    apt-get install -y -q apt-transport-https curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -k https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && \
	echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.1" | tee -a /etc/apt/sources.list.d/varnish-cache.list && \
        apt-get update -y -q && \
        apt-get install -y -q gcc libjemalloc1 libedit2 && \
        curl -O https://repo.varnish-cache.org/pkg/5.0.0/varnish_5.0.0-1_amd64.deb && \
        dpkg -i varnish_5.0.0-1_amd64.deb &&\
        rm varnish_5.0.0-1_amd64.deb && \
	apt-get install -y -q varnish-agent && \
	rm -rf /var/lob/apt/lists/*
	
ADD docker-entrypoint.sh /usr/bin/entrypoint.sh
ADD varnish /etc/default/varnish

RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 6081 6082 6085

ENTRYPOINT ["/usr/bin/entrypoint.sh"] 
