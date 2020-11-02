set -e
pwd

##初始化数据库
sh /data/docker/bkci/support-files/codecc/db_data.sh $MONGO_HOST $MONGO_PORT $MONGO_USER $MONGO_PASS

## 初始化配置
./codecc_render_tpl -m codecc /data/docker/bkci/support-files/codecc/templates/*.yml
backends=(task)
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