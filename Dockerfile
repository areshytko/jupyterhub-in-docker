FROM ubuntu:20.04

RUN /bin/bash -c "apt update && \
   apt install -y python3 python3-pip python3-dev wget lsb-release && \
   ln -sf /usr/bin/python3 /usr/bin/python"

RUN /bin/bash -c 'wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    export VERSION=node_14.x && export DISTRO="$(lsb_release -s -c)" && \
    echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs'

RUN bin/bash -c "mkdir docker-tmp && cd docker-tmp && \
    wget https://download.docker.com/linux/static/stable/x86_64/docker-17.03.0-ce.tgz && \
    tar -xzf docker-17.03.0-ce.tgz && mv ./docker/docker /usr/bin && cd .. && rm -rf docker-tmp"

RUN python -m pip install --upgrade --no-cache pip

RUN /bin/bash -c "python -m pip install --no-cache \
   jupyterhub==1.4.* \
   dockerspawner==12.0.* \
   jupyter==1.0.* \
   jupyterhub-nativeauthenticator==0.0.7 \
   PyYAML==5.4.* && \
   npm install -g configurable-http-proxy"

RUN mkdir -p /jupyterhub/
WORKDIR /jupyterhub/

EXPOSE 8010

COPY jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py

CMD ["jupyterhub", "-f", "/etc/jupyterhub/jupyterhub_config.py"]