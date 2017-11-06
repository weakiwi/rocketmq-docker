#!/bin/bash

set -x
sed -i "s/4g/128m/g" ${ROCKETMQ_HOME}/bin/runserver.sh
sed -i "s/8g/128m/g" ${ROCKETMQ_HOME}/bin/runserver.sh
sed -i "s/2g/128m/g" ${ROCKETMQ_HOME}/bin/runserver.sh
sed -i "s/4g/128m/g" ${ROCKETMQ_HOME}/bin/runbroker.sh
sed -i "s/8g/128m/g" ${ROCKETMQ_HOME}/bin/runbroker.sh
sed -i "s/2g/128m/g" ${ROCKETMQ_HOME}/bin/runbroker.sh
export ADDRESS="rocketmqnamesrv2:9876,rocketmqnamesrv1:9876"
namesrv1=`ping rocketmqnamesrv1 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
namesrv2=`ping rocketmqnamesrv2 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
if [ "${ROCKETMQ_ROLE}x" == "broker-a"x ];
then
    /root/portcheck
    namesrv1=`ping rocketmqnamesrv1 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
    namesrv2=`ping rocketmqnamesrv2 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
    cd ${ROCKETMQ_HOME} && sh bin/mqbroker -c conf/2m-2s-sync/broker-a.properties -n rocketmqnamesrv1,rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-a-slave"x ];
then
    /root/portcheck
    namesrv1=`ping rocketmqnamesrv1 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
    namesrv2=`ping rocketmqnamesrv2 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
    cd ${ROCKETMQ_HOME} && sh bin/mqbroker -c ../conf/2m-2s-sync/broker-a-s.properties -n rocketmqnamesrv1:9876,rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-b"x ];
then
    /root/portcheck
    namesrv1=`ping rocketmqnamesrv1 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
    namesrv2=`ping rocketmqnamesrv2 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
    cd ${ROCKETMQ_HOME} && sh bin/mqbroker -c ../conf/2m-2s-sync/broker-b.properties -n rocketmqnamesrv1:9876,rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "broker-b-slave"x ];
then
    /root/portcheck
    namesrv1=`ping rocketmqnamesrv1 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
    namesrv2=`ping rocketmqnamesrv2 -c1 | grep from | awk '{ print $4 }'|cut -d: -f1`
    cd ${ROCKETMQ_HOME} && sh bin/mqbroker -c ../conf/2m-2s-sync/broker-b-s.properties -n rocketmqnamesrv1:9876,rocketmqnamesrv2:9876
elif [ "${ROCKETMQ_ROLE}x" == "namesrv"x ];
then
    cd ${ROCKETMQ_HOME} && sh bin/runserver.sh org.apache.rocketmq.namesrv.NamesrvStartup
else
    echo "env ROCKETMQ_ROLE is empty, exit......."
fi
