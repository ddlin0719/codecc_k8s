# 使用helm安装
source ../../env.properties

kubectl create ns bkcodecc

kubectl delete job/configuration -n bkcodecc

if $initConfig; then
  echo 'unintall bk codecc with initConfig'
  helm3 uninstall bkcodecc -n bkcodecc

  echo 'install bk codecc with initConfig'
  helm3 install bkcodecc ./bkcodecc --set image.hub=$hub,volume.nfs.server=$nfs_server --namespace $namespace -f values.yaml
else
  echo 'unintall bk codecc'
  helm3 uninstall bkcodecc -n bkcodecc

  echo 'install bk codecc'
  helm3 install bkcodecc ./bkcodecc --set image.hub=$hub,volume.nfs.server=$nfs_server --no-hooks --namespace $namespace -f values.yaml
fi

kubectl get pod -n 'bkcodecc'