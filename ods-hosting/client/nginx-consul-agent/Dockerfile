FROM nginx:1.15-alpine
LABEL version="1.0"
LABEL description="nginx with consul agent for the client part of the hosting role"
LABEL product="ODS SManager"

RUN apk add bash curl busybox-extras
#RUN curl -L https://releases.hashicorp.com/consul-template/0.27.2/consul-template_0.27.2_linux_amd64.zip -o consul-template.zip
ADD consul_1.11.3_linux_amd64.zip ./consul.zip
RUN unzip consul.zip -d /usr/local/bin && \
 cd /usr/local/bin && \
 chmod +x consul
RUN mkdir -p /consul/config && mkdir /consul/data

ADD conf/ /etc/nginx/conf.d/
RUN rm -fv /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443
ADD *.sh /
RUN chmod +x /*.sh
CMD /entrypoint.sh
