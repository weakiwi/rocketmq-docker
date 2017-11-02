FROM registry.cn-hangzhou.aliyuncs.com/weakiwi/rocketmq_docker
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
CMD ["/root/entrypoint.sh"]
