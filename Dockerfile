FROM registry.cn-hangzhou.aliyuncs.com/acs/maven

# Rocketmq version
ENV ROCKETMQ_VERSION rocketmq-all-4.1.0-incubating

# Rocketmq home
ENV ROCKETMQ_HOME  /opt/rocketmq-${ROCKETMQ_VERSION}/distribution


COPY settings.xml /usr/share/maven/ref/
COPY entrypoint.sh /root/entrypoint.sh
COPY portcheck /root/portcheck
RUN chmod +x /root/portcheck

WORKDIR  ${ROCKETMQ_HOME}

RUN mkdir -p \
		/opt/logs \
	    /opt/store

ADD rocketmq-all-4.1.0-incubating.tar /opt

RUN chmod -R 777 bin
RUN chmod +x /root/entrypoint.sh
WORKDIR /opt/rocketmq-${ROCKETMQ_VERSION}


RUN mvn -Prelease-all -DskipTests clean install -U
ENV ROCKETMQ_HOME  /opt/rocketmq-${ROCKETMQ_VERSION}/distribution/target/apache-rocketmq
WORKDIR  ${ROCKETMQ_HOME}

ENV JAVA_OPT " -Duser.home=/opt"

CMD ["/root/entrypoint.sh"]
