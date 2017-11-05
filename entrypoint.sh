#!/bin/bash

set -x
sed -i "s/4g/128mg" ${ROCKETMQ_HOME}/bin/runserver.sh
sed -i "s/8g/128mg" ${ROCKETMQ_HOME}/bin/runserver.sh
sed -i "s/2g/128mg" ${ROCKETMQ_HOME}/bin/runserver.sh
sed -i "s/4g/128mg" ${ROCKETMQ_HOME}/bin/runbroker.sh
sed -i "s/8g/128mg" ${ROCKETMQ_HOME}/bin/runbroker.sh
sed -i "s/2g/128mg" ${ROCKETMQ_HOME}/bin/runbroker.sh
if [ "${ROCKETMQ_ROLE}x" == "broker-a"x ];
then
    cd ${ROCKETMQ_HOME} && sh bin/mqbroker -c ../conf/2m-2s-sync/broker-a.properties -n rockermqnamesrv1:9876, rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-a-slave"x ];
then
    cd ${ROCKETMQ_HOME} && sh bin/mqbroker -c ../conf/2m-2s-sync/broker-a-s.properties -n rockermqnamesrv1:9876, rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-b"x ];
then
    cd ${ROCKETMQ_HOME} && sh bin/mqbroker -c ../conf/2m-2s-sync/broker-b.properties -n rockermqnamesrv1:9876, rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-b-slave"x ];
then
    cd ${ROCKETMQ_HOME} && sh bin/mqbroker -c ../conf/2m-2s-sync/broker-b-s.properties -n rockermqnamesrv1:9876, rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "namesrv"x ];
then
    cd ${ROCKETMQ_HOME} && sh bin/runserver.sh org.apache.rocketmq.namesrv.NamesrvStartup
else
    echo "env ROCKETMQ_ROLE is empty, exit......."
fi
