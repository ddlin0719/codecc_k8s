FROM bkci/jdk

LABEL maintainer="blueking"

COPY import_config_codecc.sh /data/docker/bkci/codecc/configuration/
COPY codecc_render_tpl /data/docker/bkci/codecc/configuration/
COPY support-files /data/docker/bkci/codecc/configuration/support-files

RUN yum clean all &&\
    yum update -y &&\
    yum install -y mongodb

RUN chmod +x /data/docker/bkci/codecc/configuration/import_config_codecc.sh \
    && chmod +x /data/docker/bkci/codecc/configuration/codecc_render_tpl