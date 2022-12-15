FROM phpmyadmin/phpmyadmin:5.2.0
LABEL version="1.0"
LABEL description="phpmyadmin with consul agent for client part of ODS hosting"
LABEL product="ODS SManager"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    libzip-dev \
    iproute2

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ADD consul_1.11.3_linux_amd64.zip ./consul.zip
RUN unzip consul.zip -d /usr/local/bin && \
 cd /usr/local/bin && \
 chmod +x consul
RUN mkdir -p /consul/config && mkdir /consul/data

ADD entrypoint.sh ./
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
CMD ["apache2-foreground"]