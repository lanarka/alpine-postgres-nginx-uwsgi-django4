# NEBERE
#COPY deploy/resolv.conf /etc/resolv.conf
# ANI HOSTNAME

# SOLKIN 1.0
FROM amd64/alpine:3.19.0
LABEL my.mach="my-mach"
RUN echo "mach_1.0/alpine_3.19.0" > /opt/issue.txt

# SYSTEM
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN apk update
RUN apk add \
	openrc \
	linux-virt \
	openntpd \
	nginx \
	python3 \
	py3-pip \
	postgresql \
	joe \
	gcc \
	build-base \
	linux-headers \
	python3-dev

# -joe

RUN export TZ='Europe/Bratislava' 
RUN echo "export TZ='$TZ'" >> /etc/profile.d/timezone.sh
RUN rc-update add openntpd

RUN echo "root:root" | chpasswd
RUN rc-update add root

# NETWORK
COPY deploy/interfaces.static /etc/network/interfaces

# NGINX
COPY deploy/nginx.conf /etc/nginx/http.d/default.conf
RUN rc-update add nginx default

# UWSGI
COPY deploy/start-uwsgi.sh /opt/mach-env/start-uwsgi.sh
RUN chmod +x /opt/mach-env/start-uwsgi.sh

# PYTHON ENV
COPY deploy/req.txt .
RUN python3 -m venv /opt/mach-env
RUN /opt/mach-env/bin/pip install --upgrade pip
RUN /opt/mach-env/bin/pip install -r req.txt
RUN mv req.txt /opt/mach-env/req.txt
COPY deploy/start-devsrv.sh /opt/mach-env/start-devsrv.sh
RUN chmod +x /opt/mach-env/start-devsrv.sh

# CLEAN
RUN apk del \
	gcc \
	build-base \
	linux-headers \
	python3-dev

RUN rm -r /root/.cache
RUN apk cache clean

# APPLICATION
COPY construct/ /opt/mach-env/construct
