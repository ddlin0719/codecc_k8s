FROM bkci/jdk

LABEL maintainer="blueking"

ENV module task

COPY boot-task.jar /data/docker/bkci/codecc/backend/
COPY module_run.sh /data/docker/bkci/codecc/backend/
COPY classpath /data/docker/bkci/codecc/backend/classpath
COPY bootstrap /data/docker/bkci/codecc/backend/bootstrap

RUN chmod +x /data/docker/bkci/codecc/backend/module_run.sh