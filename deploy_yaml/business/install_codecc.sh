# 使用helm安装
source codecc_k8s/env.properties

# kubectl create delete bkcodecc

kubectl create ns bkcodecc

if $initConfig; then
  echo 'unintall bk codecc with initConfig'
  helm3 uninstall bkcodecc -n bkcodecc

  echo 'install bk codecc with initConfig'
  helm3 install bkcodecc codecc_k8s/deploy_yaml/business/bkcodecc --set image.hub=$hub,volume.nfs.server=$nfs_server \
  --namespace $namespace -f codecc_k8s/deploy_yaml/business/codecc_values.yaml
else
  echo 'unintall bk codecc'
  helm3 uninstall bkcodecc -n bkcodecc

  echo 'install bk codecc'
  helm3 install bkcodecc codecc_k8s/deploy_yaml/business/bkcodecc --set image.hub=$hub,volume.nfs.server=$nfs_server \
  --no-hooks --namespace $namespace -f codecc_k8s/deploy_yaml/business/codecc_values.yaml
fi

sleep 3s
echo "kubectl get job -n 'bkcodecc'"
kubectl get job -n 'bkcodecc'

echo "kubectl get pod -n 'bkcodecc'"
kubectl get pod -n 'bkcodecc'