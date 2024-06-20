FROM ubuntu:22.04
LABEL vendor="cedrickoka/kolla-ansible" maintainer="okacedrick@gmail.com" version="1.0.0"

## Add Docker's official GPG key
RUN apt-get update && \
    apt-get install -yqq \
        ca-certificates \
        curl
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null

## Install kolla dependencies
RUN apt-get update && \
    apt-get install -yqq \
        ansible \
        bash \
        coreutils \
        curl \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        file \
        gcc \
        gettext \
        git \
        g++ \
        make \
        multipath-tools \
        musl \
        libffi-dev \
        libssl-dev \
        unzip \
        python3-dev \
        python3-pip

RUN pip3 install --no-cache-dir -U --break-system-packages \
        pip==24.0 \
        diskimage-builder==3.33.0 \
        docker==7.1.0 \
        kolla==18.0.0 \
        kolla-ansible==18.0.0 \
        python-openstackclient==6.6.0 && \
    mkdir -p /etc/kolla

COPY etc/ansible/ansible.cfg /etc/ansible/ansible.cfg
