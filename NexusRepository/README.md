Sonatype Nexus — программный продукт, который представляет собой менеджер репозиториев для хранения артефактов. Поддерживаются такие форматы артефактов, как Maven, образы Docker, Python PyPI, RubyGems, npm, nuget, deb и другие. С полным списком поддерживаемых артефактов можно ознакомиться в официальной документации.

После запуска необходимо получить пароль администратора (логин: admin). Для этого нужно подключитсьяк shell контейнера(в списке контейнеров с права) и выполнить команду:
```
cat nexus-data/admin.password
```
Файл admin.password внутри контейнера будет удален сразу после первого входа в web интерфейс.