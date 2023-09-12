# PHP example
This is example of custom project without prepared php image.
## Dependencies
### Nginx ingress controller
This role constructed for work only with `Nginx ingress conroller` role. Smanager ingress conroller(ssl or hhtp only) must be deployed on your server before you deploy this role

**If you don't want use** `Nginx ingress controller` you can comment(or remove) next lines in [advanced editor](./advanced/edit):
```
# # comment(or remove) part of startup script:
    - docker-compose up -d consul-client
    - |
      docker-compose exec consul-client consul services register\
      -name=${ODS_SM_GENERATE_UUIDv4_0}\
      -address=${ODS_SM_GENERATE_UUIDv4_0}\
      -port=80\
      -tag=nginx\
      -meta="site_domain=${SITE_DOMAIN}"

# comment(or remove) consul service:
  consul-client:
    command:  agent -node=client-${ODS_SM_GENERATE_UUIDv4_0} -retry-join=consul
    image: ${CONSUL_IMAGE}
    networks:
      - smanager-ingress-net
    restart: unless-stopped

# comment(or remove) all defintion of networks:

    networks:
      - smanager-ingress-net
      - default

networks:
  smanager-ingress-net:
    name: smanager-ingress-net
    external: true

```
## Start
1. Deploy `Nginx ingress controller` role to your server or remove client code as described above.
2. Change `docker-compose.yml` file and `.env` file in [advanced editor](./advanced/edit) (if needed)
3. Deploy role to your server  
**Important**: first deploy will **failed** it is **normal**, because you still not placed `Dockerfile`
4. Channge(if needed) and place [Dockerfile](https://raw.githubusercontent.com/leftusername/smanager-templates/github/php/php/Dockerfile) in `php` directory on your server (by default roles stored in /opt/username)  
5. Place code of your project in `php/src` directory  
6. Redeploy you role

You must have next files structure:
```
/opt/username/role/
                    |   .env
                    |   docker-compose.yml
                    |
                    |---php
                        |   Dockerfile
                        |
                        |---src
                                index.php
```