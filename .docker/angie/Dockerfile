FROM docker.angie.software/angie:minimal AS img_build

ARG WORKDIR="/src"

EXPOSE 80

FROM img_build AS app_devel

# Configuration
COPY conf/angie.conf /etc/angie/angie.conf
