## 1.介绍

通过使用docker-compose,将一些日常开发中经常使用的服务进行编排,集装在docker中,以容器的方式运行服务、管理服务、升级或者降级服务.期望达到一次构建处处使用,再也不用再像之前那么复杂的安装、配置、启动......

## 2.配置修改

### 2.1 第一步复制配置文件

```shell
cp env-example .env
```

### 2.2 修改 .env

```shell
# 改成自己电脑的IP
DOCKER_HOST_IP=改成自己电脑的IP
# 本地php项目的上级目录
APP_CODE_PATH_HOST=本地php项目的上级目录
# 持久卷位置
DATA_PATH_HOST=持久卷位置
```

## 3.服务列表

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

# 4.使用介绍

## 4.1 获取项目

```bash
git clone https://github.com/shershon1991/docker-compose-server.git
```

## 4.2 安装docker-compose

```bash
# 下载
curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# 赋权
chmod +x /usr/local/bin/docker-compose
```

## 5.启动服务

### 5.1 启动mongo

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

### 5.2 启动PHP环境(linux/nginx/mysql/php-fpm/redis)

```bash
➜  docker-compose-server git:(master) chmod +x ./bin/start-phpenv.sh

➜  docker-compose-server git:(master) ./bin/start-phpenv.sh
Starting env_redis_1     ... done
Starting env_workspace_1 ... done
Starting env_mysql_1     ... done
Starting env_php-fpm_1   ... done
Starting env_nginx_1     ... done


```