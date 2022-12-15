FROM tinyfilemanager/tinyfilemanager:master
LABEL version="1.0"
LABEL description="Tinyfilemanager with consult-template for the provider part of the hosting role"
LABEL product="ODS SManager"


RUN apk add bash


# Скачиваем consul-template, распаковываем, готовим папку для шаблончиков
ADD consul-template_0.27.2_linux_amd64.zip ./consul-template.zip
RUN unzip consul-template.zip -d /usr/local/bin && \
 cd /usr/local/bin && \
 chmod +x consul-template && \
 mkdir -p /etc/consul-template/templates

ADD templates/ /etc/consul-template/templates

ADD entrypoint.sh ./
RUN chmod +x entrypoint.sh
EXPOSE 80
CMD ./entrypoint.sh
