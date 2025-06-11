FROM docker:dind 

RUN apk add --no-cache openssh bash sudo \
	&& adduser -D anisble \
	&& echo "ansible:ansible" | chpasswd \
	&& addgroup ansible wheel 
	
RUN mkdir /var/run/sshd

EXPOSE 22

CMD ["/usr/bin/sshd", "-D"]

