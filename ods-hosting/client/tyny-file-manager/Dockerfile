FROM tinyfilemanager/tinyfilemanager:master
LABEL version="1.0"
LABEL description="Tinyfilemanager with consult-agent for the clinet part of the hosting role"
LABEL product="ODS SManager"


RUN apk add bash sudo


ADD consul_1.11.3_linux_amd64.zip ./consul.zip
RUN unzip consul.zip -d /usr/local/bin && \
 cd /usr/local/bin && \
 chmod +x consul
RUN mkdir -p /consul/config && mkdir /consul/data

#RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
ADD php.ini-production "$PHP_INI_DIR/php.ini"

ADD config.php ./
ADD entrypoint.sh ./
RUN chmod +x entrypoint.sh
EXPOSE 8080
CMD ./entrypoint.sh
