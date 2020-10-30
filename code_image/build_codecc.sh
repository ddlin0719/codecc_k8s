#!/bin/bash
set -e
echo "导入环境变量开始..."
source ../env.properties

TMP_PACKAGE="tmp_codecc"
IMAGE_VERSION="0.0.1-20201030"

mkdir -p $TMP_PACKAGE && rm -rf $TMP_PACKAGE/*

echo "package path: "`pwd`
echo "导入环境变量完成"
echo "docker push hub:"$hub
echo "docker push image versio:"$IMAGE_VERSION

##打包gateway镜像
echo "打包gateway镜像开始..."
rm -rf $TMP_PACKAGE/*
mkdir $TMP_PACKAGE/frontend
cp -rf bk-ci/src/frontend/devops-codecc $TMP_PACKAGE/frontend
cp -rf bk-ci/src/gateway/core $TMP_PACKAGE/gateway
cp -rf gateway/gateway_run_codecc.sh $TMP_PACKAGE/
cp -rf gateway/codecc_render_tpl $TMP_PACKAGE/
mkdir $TMP_PACKAGE/support-files
cp -rf bk-ci/support-files/codecc/* $TMP_PACKAGE/support-files
docker build -f gateway/gateway_codecc.Dockerfile -t $hub/bkci-codecc-gateway:$IMAGE_VERSION ./$TMP_PACKAGE --network=host
docker push $hub/bkci-codecc-gateway:$IMAGE_VERSION
echo "打包gateway镜像完成"

## 打包backend镜像
echo "打包backend镜像开始..."
#backends=(task defect report asyncreport codeccjob schedule openapi apiquery quartz)
backends=(task)
for var in ${backends[@]};
do
    echo "build $var start..."

    rm -rf $TMP_PACKAGE/*
    cp -r backend/classpath $TMP_PACKAGE/
    cp -r backend/bootstrap $TMP_PACKAGE/
    cp -r backend/font $TMP_PACKAGE/
    cp bk-ci/src/backend/codecc/release/boot-$var.jar $TMP_PACKAGE/

    cp backend/module_run_codecc.sh $TMP_PACKAGE/

    docker build -f backend/$var.Dockerfile -t $hub/bkci-codecc-$var:$IMAGE_VERSION $TMP_PACKAGE --network=host
    docker push $hub/bkci-codecc-$var:$IMAGE_VERSION
    echo "build $var finish..."
done

## 打包配置镜像
echo '打包配置镜像中...'
rm -rf $TMP_PACKAGE/*
mkdir $TMP_PACKAGE/support-files
cp -rf bk-ci/support-files/codecc/* $TMP_PACKAGE/support-files
cp -rf configuration/import_config_codecc.sh $TMP_PACKAGE/
cp -rf configuration/codecc_render_tpl $TMP_PACKAGE/
docker build -f configuration/configuration_codecc.Dockerfile -t $hub/bkci-codecc-configuration:$IMAGE_VERSION $TMP_PACKAGE --network=host
docker push $hub/bkci-codecc-configuration:$IMAGE_VERSION
echo '打包配置镜像完成'

set +e