#! /bin/sh
# nohup consul agent -datacenter=dc -domain=codecc -data-dir=/tmp -join=$CONSUL_SERVER &
mkdir -p /data/docker/bkci/codecc/backend/logs
java -cp boot-$module.jar \
    -server \
    -Xloggc:/data/docker/bkci/codecc/backend/logs/gc.log \
    -XX:NewRatio=1 \
    -XX:SurvivorRatio=8 \
    -XX:+PrintTenuringDistribution \
    -XX:+PrintGCDetails \
    -XX:+PrintGCDateStamps \
    -XX:+UseConcMarkSweepGC \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:HeapDumpPath=oom.hprof \
    -XX:ErrorFile=error_sys.log \
    -Dservice-suffix=codecc \
    -Dloader.path="/data/docker/bkci/codecc/backend/classpath/" \
    -Dspring.profiles.active=dev \
    -Dspring.cloud.config.enabled=false \
    -Dservice.log.dir=/data/docker/bkci/codecc/backend/logs/ \
    -Dsun.jnu.encoding=UTF-8 \
    -Dfile.encoding=UTF-8 \
    -Dspring.config.location=/data/docker/bkci/codecc/backend/bootstrap/bootstrap.yaml \
    -Dspring.cloud.consul.host=$NODE_IP \
    org.springframework.boot.loader.PropertiesLauncher