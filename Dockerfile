FROM alpine:latest 

RUN apk add --no-cache openssh bash sudo shadow \
	&& adduser -D ansible \
	&& echo "ansible:ansible" | chpasswd \
	&& addgroup ansible wheel 
	
RUN mkdir -p /var/run/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

