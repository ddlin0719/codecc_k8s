#!/bin/bash


#git clone https://github.com/linjun-ddddd/codecc_k8s.git

# [manual] get codecc package && tar -xvf bkcodecc-*.tar.gz codecc/

# [manual] change config in codecc_k8s/env.properties

# [manual] change config in codecc_k8s/deploy_yaml/business/codecc_values.yaml

# [manual] change config in codecc_k8s/deploy_yaml/base/ingress.yaml


sh codecc_k8s/code_image/build_codecc.sh

sh codecc_k8s/deploy_yaml/base/deploy_codecc.sh

sh codecc_k8s/deploy_yaml/business/install_codecc.sh

