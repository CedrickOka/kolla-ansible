FROM docker:23.0.6-dind-alpine3.17
LABEL vendor="cedrickoka/kolla-ansible" maintainer="okacedrick@gmail.com" version="1.0.0"

SHELL ["/bin/sh", "-xo", "pipefail", "-c"]

## Install system dependencies
RUN apk add --no-cache --update \
		ansible=6.6.0-r0 \
		bash=5.2.15-r0 \
		debootstrap=1.0.128-r0 \
    	gcc=12.2.1_git20220924-r4 \
		gettext=0.21.1-r1 \
		git=2.38.5-r0 \
    	g++=12.2.1_git20220924-r4 \
    	make=4.3-r1 \
    	multipath-tools=0.9.3-r2 \
    	musl=1.2.3-r5 \
    	libffi-dev=3.4.4-r0 \
    	openssl-dev=3.0.11-r0 \
    	python3-dev=3.10.13-r0 \
    	py3-pip=22.3.1-r1 \
    	qemu=7.1.0-r7 && \
    	\
    	pip3 install --no-cache-dir -U \
			pip==23.2.1 \
			diskimage-builder==3.31.0 \    
			kolla==16.1.0  \
			kolla-ansible==16.1.0 \
			python-openstackclient==6.3.0 && \
		\
		mkdir -p /etc/kolla && \
		cp -r /usr/share/kolla-ansible/etc_examples/kolla/* /etc/kolla

COPY etc/ansible/ansible.cfg /etc/ansible/ansible.cfg
COPY etc/kolla/* /etc/kolla/
