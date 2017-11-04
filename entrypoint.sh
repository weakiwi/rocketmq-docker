#!/bin/bash

set -x

if [ "${ROCKETMQ_ROLE}x" == "broker-a"x ];
then
    cd ${ROCKETMQ_HOME}/target/apache-rocketmq/bin
    bash mqbroker -c ../conf/2m-2s-sync/broker-a.properties -n rockermqnamesrv1:9876, rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-a-slave"x ];
then
    cd ${ROCKETMQ_HOME}/target/apache-rocketmq/bin
    bash mqbroker -c ../conf/2m-2s-sync/broker-a-s.properties -n rockermqnamesrv1:9876, rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-b"x ];
then
    cd ${ROCKETMQ_HOME}/target/apache-rocketmq/bin
    bash mqbroker -c ../conf/2m-2s-sync/broker-b.properties -n rockermqnamesrv1:9876, rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-b-slave"x ];
then
    cd ${ROCKETMQ_HOME}/target/apache-rocketmq/bin
    bash mqbroker -c ../conf/2m-2s-sync/broker-b-s.properties -n rockermqnamesrv1:9876, rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "namesrv"x ];
then
    cd ${ROCKETMQ_HOME}/bin
    ROCKETMQ_HOME=""
    sh bin/runserver.sh org.apache.rocketmq.namesrv.NamesrvStartup
else
    echo "env ROCKETMQ_ROLE is empty, exit......."
fi
