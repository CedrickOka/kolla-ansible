FROM docker:20.10.24-dind-alpine3.17
LABEL vendor="cedrickoka/kolla-ansible" maintainer="okacedrick@gmail.com" version="1.0.0"

SHELL ["/bin/sh", "-xo", "pipefail", "-c"]

## Install system dependencies
RUN apk add --no-cache --update \
		ansible=6.6.0-r0 \
		bash=5.2.15-r0 \
    	gcc=12.2.1_git20220924-r4 \
		git=2.38.4-r1 \
    	g++=12.2.1_git20220924-r4 \
    	make=4.3-r1 \
    	musl=1.2.3-r4 \
    	libffi-dev=3.4.4-r0 \
    	openssl-dev=3.0.8-r4 \
    	python3-dev=3.10.11-r0 \
    	py3-pip=22.3.1-r1 && \
    	\
    	pip3 install --no-cache-dir -U \
			pip==23.1 \
			kolla==15.1.0 \
			kolla-ansible==15.1.0 && \
		\
		mkdir -p /etc/kolla && \
		cp -r /usr/share/kolla-ansible/etc_examples/kolla/* /etc/kolla

COPY etc/ansible/ansible.cfg /etc/ansible/ansible.cfg
COPY etc/kolla/* /etc/kolla/

ENTRYPOINT ["tail", "-f", "/dev/null"]
