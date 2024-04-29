FROM alpine:latest

RUN apk add --update --no-cache openssh
RUN apk add sqlite
RUN apk add python3
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN adduser -h /home/user -s /bin/sh -D user
RUN echo -n "user:defaultpassword" | chpasswd
#RUN echo -n "root:root" | chpasswd
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY entrypoint.sh /
