FROM alpine:latest 

RUN apk add --no-cache openssh bash sudo shadow \
	&& adduser -D ansible \
	&& echo "ansible:ansible" | chpasswd \
	&& addgroup ansible wheel 
	
RUN mkdir -p /var/run/sshd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

