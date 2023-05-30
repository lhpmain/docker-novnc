# 端口规划
# 9000 - nginx
# 9001 - websocketify
# 5911 - tigervnc

# based on ubuntu 18.04 LTS
FROM ubuntu:18.04

# 各种环境变量
ENV LANG=en_US.UTF-8 \
	LC_ALL=en_US.UTF-8 \
	S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
	S6_CMD_ARG0=/sbin/entrypoint.sh \
	VNC_GEOMETRY=800x600 \
	VNC_PASSWD='MAX8char' \
	USER_PASSWD='' \
	HTTP_AUTH_USER='' \
	HTTP_AUTH_PASSWD='' \
	DEBIAN_FRONTEND=noninteractive

# 首先加用户，防止 uid/gid 不稳定
RUN groupadd user && useradd -m -g user user && \
	# 安装依赖和代码
	apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		git \
		ca-certificates wget locales \
		nginx sudo apache2-utils \
		xorg openbox python3 python3-pip rxvt-unicode && \
	pip3 install numpy && \
	# s6-overlay@v1.22.1.0
	wget -O - https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz | tar -xzv && \
	# workaround for https://github.com/just-containers/s6-overlay/issues/158
	ln -s /init /init.entrypoint && \
	# tigervnc@v1.10.1
	wget -O /tmp/tigervnc.tar.gz https://sourceforge.net/projects/tigervnc/files/stable/1.10.1/tigervnc-1.10.1.x86_64.tar.gz/download && \
	tar xzf /tmp/tigervnc.tar.gz -C /tmp && \
	chown root:root -R /tmp/tigervnc-1.10.1.x86_64 && \
	tar c -C /tmp/tigervnc-1.10.1.x86_64 usr | tar x -C / && \
	locale-gen en_US.UTF-8 && \
	mkdir -p /app/src && \
	# novnc@v1.4.0
	git clone --depth=1 --branch v1.4.0 https://github.com/novnc/noVNC.git /app/src/novnc && \
	# novnc@v0.11.0
	git clone --depth=1 --branch v0.11.0 https://github.com/novnc/websockify.git /app/src/websockify && \
	apt-get purge -y git wget && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -fr /tmp/* /app/src/novnc/.git /app/src/websockify/.git /var/lib/apt/lists

# copy files
COPY ./docker-root /

EXPOSE 9000/tcp 9001/tcp 5911/tcp

ENTRYPOINT ["/init.entrypoint"]
CMD ["start"]
