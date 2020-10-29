set -e

##初始化数据库
for SQL in /data/docker/bkci/codecc/configuration/support-files/codecc/nosql/db_task_data/*.json; do TODO() done
for SQL in /data/docker/bkci/codecc/configuration/support-files/codecc/nosql/db_defect_data/*.json; do TODO() done

## 初始化配置
./codecc_render_tpl -m codecc ./support-files/codecc/templates/*.yml
backends=(task defect report asyncreport codeccjob schedule openapi apiquery quartz)
cd ..
echo '[' > consul_kv.json
for var in ${backends[@]};
do
    echo "properties $var start..."
    yaml_base64=$(base64 /data/docker/bkci/etc/codecc/application-$var.yml -w 0)
    echo '	{' >> consul_kv.json
    echo '		"key": "config/'$var'codecc:dev/data",' >> consul_kv.json
    echo '		"flags": 0,' >> consul_kv.json
    echo '    "value":"'$yaml_base64'"' >> consul_kv.json
    echo '	},' >> consul_kv.json
    echo "properties $var finish..."
done

echo "properties application start..."
yaml_base64=$(base64 /data/docker/bkci/etc/codecc/common.yml -w 0)
echo '	{' >> consul_kv.json
echo '		"key": "config/application:dev/data",' >> consul_kv.json
echo '		"flags": 0,' >> consul_kv.json
echo '    "value":"'$yaml_base64'"' >> consul_kv.json
echo '	}' >> consul_kv.json
echo "properties application finish..."
echo ']' >> consul_kv.json

consul kv import --http-addr=$CONSUL_SERVER:8500 @consul_kv.json