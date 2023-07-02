## 1.介绍

通过使用docker-compose,将一些日常开发中经常使用的服务进行编排,集装在docker中,以容器的方式运行服务、管理服务、升级或者降级服务.期望达到一次构建处处使用,再也不用再像之前那么复杂的安装、配置、启动......

## 2.服务列表

- workspace
- php-fpm
- nginx
- mysql
- mongodb
- redis
- memcached
- rabbitmq
- elasticsearch
- logstash
- kibana
- grafana
- rocketmq
- pulsar
- consul
- prometheus
- zipkin
- hyperf
- dsp
- jenkins

# 3.使用介绍

## 3.1 获取项目

```bash
git clone https://github.com/shershon1991/docker-compose-server.git
```

## 3.2 配置修改

### 3.2.1 第一步复制配置文件

```shell
cp env-template .env
cp docker-compose-template.yml docker-compose.yml
```

### 3.2.2 修改 .env

```shell
# 改成自己电脑的IP
DOCKER_HOST_IP=改成自己电脑的IP
# 本地php项目的上级目录
APP_CODE_PATH_HOST=本地php项目的上级目录
# 持久卷位置
DATA_PATH_HOST=持久卷位置
```

## 3.3 安装docker-compose

```bash
# 下载
curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# 赋权
chmod +x /usr/local/bin/docker-compose
```

## 4.启动服务

### 4.1 启动mongo

```bash
➜  docker-compose-server git:(master)  docker-compose build mongo
Building mongo
Sending build context to Docker daemon  2.048kB
Step 1/4 : FROM mongo:latest
 ---> 4130848d45a9
Step 2/4 : VOLUME /data/db /data/configdb
 ---> Using cache
 ---> 128907217a94
Step 3/4 : CMD ["mongod"]
 ---> Using cache
 ---> c945d386bec1
Step 4/4 : EXPOSE 27017
 ---> Using cache
 ---> 6f4c698e2243
Successfully built 6f4c698e2243
Successfully tagged env_mongo:latest

➜  docker-compose-server git:(master)  docker-compose up -d mongo
Creating env_mongo_1 ... done

➜  docker_compose_server git:(master)  docker-compose ps
       Name                     Command             State            Ports
------------------------------------------------------------------------------------
env_mongo_1   docker-entrypoint.sh mongod   Up      0.0.0.0:27017->27017/tcp
```

### 4.2 启动 lnmp 环境(linux、nginx、mysql、php-fpm、redis)

```bash
➜  docker-compose-server git:(master) chmod +x ./bin/start-phpenv.sh

➜  docker-compose-server git:(master) ./bin/start-phpenv.sh
Starting env_redis_1     ... done
Starting env_workspace_1 ... done
Starting env_mysql_1     ... done
Starting env_php-fpm_1   ... done
Starting env_nginx_1     ... done

➜  docker-compose-server git:(master) docker-compose ps
     Name                    Command               State                                          Ports
------------------------------------------------------------------------------------------------------------------------
env_mysql_1       docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp, 33060/tcp
env_nginx_1       /docker-entrypoint.sh /bin ...   Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp, 0.0.0.0:8080->8080/tcp,
                                                           0.0.0.0:8081->8081/tcp, 0.0.0.0:8082->8082/tcp, 0.0.0.0:8083->8083/tcp
env_php-fpm_1     docker-php-entrypoint php-fpm    Up      9000/tcp
env_redis_1       docker-entrypoint.sh redis ...   Up      0.0.0.0:6379->6379/tcp
env_workspace_1   /sbin/my_init                    Up      0.0.0.0:2222->22/tcp, 0.0.0.0:18080->8010/tcp, 0.0.0.0:18081->8011/tcp,
                                                           0.0.0.0:18082->8012/tcp, 0.0.0.0:18083->8013/tcp, 0.0.0.0:18084->8014/tcp,
                                                           0.0.0.0:18085->8015/tcp, 0.0.0.0:18086->8016/tcp, 0.0.0.0:18087->8017/tcp,
                                                           0.0.0.0:18088->8018/tcp, 0.0.0.0:18089->8019/tcp, 0.0.0.0:18090->8020/tcp, 9501/tcp,
                                                           9502/tcp, 9503/tcp, 9504/tcp, 9505/tcp, 9506/tcp, 9507/tcp, 9508/tcp, 9509/tcp,
                                                           9510/tcp
```

### 4.3 启动 dsp 环境(dsp、mysql、redis、rabbitmq)

#### 4.3.1 启动容器
```bash
➜  docker-compose-server git:(master) chmod +x ./bin/start-dspenv.sh

➜  docker-compose-server git:(master) ./bin/start-dspenv.sh
Starting rabbitmq ... done
Starting mysql    ... done
Starting redis    ... done
Starting dsp      ... done

➜  docker-compose-server git:(master) docker-compose ps
  Name                Command               State                                      Ports
------------------------------------------------------------------------------------------------------------------------
dsp        /bin/bash                        Up       443/tcp, 0.0.0.0:9080->9080/tcp, 0.0.0.0:9081->9081/tcp,
                                                     0.0.0.0:9082->9082/tcp, 0.0.0.0:9083->9083/tcp, 0.0.0.0:9084->9084/tcp,
                                                     0.0.0.0:9085->9085/tcp, 0.0.0.0:9086->9086/tcp, 0.0.0.0:9087->9087/tcp,
                                                     0.0.0.0:9088->9088/tcp, 0.0.0.0:9089->9089/tcp, 0.0.0.0:9090->9090/tcp
mysql      docker-entrypoint.sh mysqld      Up       0.0.0.0:3306->3306/tcp, 33060/tcp
rabbitmq   docker-entrypoint.sh rabbi ...   Exit 0
redis      docker-entrypoint.sh redis ...   Up       0.0.0.0:6379->6379/tcp
```

#### 4.3.2 进入容器

通过命令 `docker exec -it dsp /bin/bash` 进入容器，通过命令 `yum install redis` 安装redis，有些项目或者接口需要 redis，此处自行安装

#### 4.3.3 切换用户：

`su work`

#### 4.3.4 启动nginx 

`/home/work/dsp/webserver/loadnginx.sh start`

#### 4.3.5 启动php-fpm 

`/home/work/dsp/php/sbin/php-fpm-control start`

#### 4.3.6 绑定hosts

修改本地 hosts 和 `/home/work/dsp/webserver/conf/vhost` 下的对应的项目配置。以 admin.conf 为例，vhost 下的配置是 `server_name admin.dsp.com`，本地 hosts 配置是 `127.0.0.1 admin.dsp.com`

#### 4.3.7 接口访问

postman 上访问方式为 `admin.dsp.com:9080/demo/demo/list`