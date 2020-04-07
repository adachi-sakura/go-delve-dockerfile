FROM golang:alpine
MAINTAINER Adachi Sakura <805983409@qq.com>

RUN apk update && \
	apk upgrade && \
	apk add --no-cache bash git openssh g++ gcc

RUN go get github.com/derekparker/delve/cmd/dlv

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config &&\
	ssh-keygen -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key
	
RUN echo -e '123456\n123456' | passwd root

RUN echo "export GOLANG_VERSION=${GOLANG_VERSION}" >> /etc/profile &&\
	echo "export GOPATH=${GOPATH}" >> /etc/profile &&\
	echo "cd ${GOPATH}" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
