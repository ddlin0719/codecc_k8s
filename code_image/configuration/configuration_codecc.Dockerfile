FROM bkci/jdk

LABEL maintainer="blueking"

COPY import_config_codecc.sh /data/docker/bkci/codecc/configuration/
COPY render_tpl_codecc /data/docker/bkci/codecc/configuration/
COPY support-files /data/docker/bkci/codecc/configuration/support-files

RUN yum clean all &&\
    yum update -y &&\
    yum install -y mysql

RUN chmod +x /data/docker/bkci/ci/configuration/import_config_codecc.sh \
    && chmod +x /data/docker/bkci/ci/configuration/render_tpl