#!/bin/bash


#git clone https://github.com/linjun-ddddd/codecc_k8s.git

#git clone  https://github.com/Tencent/bk-ci.git


# [manual] change config in codecc_k8s/env.properties

# [manual] change config in codecc_k8s/deploy_yaml/business/values.yaml


sh codecc_k8s/code_image/build_codecc.sh


sh codecc_k8s/deploy_yaml/business/install_codecc.sh