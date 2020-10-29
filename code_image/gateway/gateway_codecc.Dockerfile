FROM bkci/openresty

LABEL maintainer="blueking"

COPY gateway /data/docker/bkci/codecc/gateway
COPY gateway_run.sh /data/docker/bkci/codecc/gateway/
COPY render_tpl /data/docker/bkci/codecc/gateway/
COPY support-files /data/docker/bkci/codecc/gateway/support-files
COPY frontend /data/docker/bkci/codecc/frontend


## lua日志目录
RUN mkdir -p /data/docker/bkci/logs/codecc/nginx/ &&\
    chown -R nobody:nobody /data/docker/bkci/logs/codecc/nginx/ &&\
    rm -rf /usr/local/openresty/nginx/conf &&\
    ln -s  /data/docker/bkci/codecc/gateway /usr/local/openresty/nginx/conf &&\
    mkdir -p /usr/local/openresty/nginx/run/ &&\
    chmod +x /data/docker/bkci/codecc/gateway/gateway_run.sh &&\
    chmod +x /data/docker/bkci/codecc/gateway/render_tpl