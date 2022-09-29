ARG ROCKETMQ_VERSION
FROM rocketmqinc/rocketmq:${ROCKETMQ_VERSION}

## 修改配置内容
USER root
# 覆盖配置文件
COPY broker.conf /opt/rocketmq-${ROCKETMQ_VERSION}/conf/broker.conf