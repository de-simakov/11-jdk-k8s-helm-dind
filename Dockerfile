FROM openjdk:11-jdk-slim

RUN apt-get update && \
    apt-get install -y \
	wget gnupg2 git socat apt-transport-https ca-certificates curl software-properties-common \
    && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" | tee -a /etc/apt/sources.list.d/docker.list \
    && \
    apt-get update && \
    apt-get -y install docker-ce \
    && \
    rm -rf /var/cache/apk/*

RUN curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.13.0-linux-amd64.tar.gz \
    && tar -zxvf helm-v2.13.0-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/ && mv linux-amd64/tiller /usr/local/bin/ \
    && rm -fr linux-amd64 \
    && rm -f helm-v2.13.0-linux-amd64.tar.gz

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.13.2/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin/ \
    && chmod +x /usr/local/bin/kubectl
