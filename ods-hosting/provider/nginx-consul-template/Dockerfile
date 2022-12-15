FROM nginx:1.15-alpine
LABEL version="1.0"
LABEL description="Web server with consult-template for the provider part of the hosting role"
LABEL product="ODS SManager"

# Устанавливаем  nginx, curl и unzip
# RUN apt-get update && apt-get install curl unzip nginx -y
RUN apk add bash curl
# Скачиваем consul-template, распаковываем, готовим папку для шаблончиков
ADD consul-template_0.27.2_linux_amd64.zip ./consul-template.zip
RUN unzip consul-template.zip -d /usr/local/bin && \
 cd /usr/local/bin && \
 chmod +x consul-template && \
 mkdir -p /etc/consul-template/templates

#RUN curl -L https://releases.hashicorp.com/consul-template/0.27.2/consul-template_0.27.2_linux_amd64.zip -o consul-template.zip && \
# unzip consul-template.zip -d /usr/local/bin && \
# cd /usr/local/bin && \
# chmod +x consul-template && \
# mkdir -p /etc/consul-template/templates
# Публикуем стандартные порты для http и https
EXPOSE 80
EXPOSE 443
# Добавляем шаблон, конфигурационный файл nginx и скрипт запуска
ADD templates/ /etc/consul-template/templates
#ADD nginx.conf /etc/nginx/nginx.conf
ADD entrypoint.sh ./
RUN chmod +x entrypoint.sh
CMD ./entrypoint.sh