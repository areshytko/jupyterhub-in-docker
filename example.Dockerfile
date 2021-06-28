FROM python:3.8
RUN pip3 install \
    'jupyterhub==1.4.*' \
    'notebook==6.*' \
    "jupyterlab"

# create a user, since we don't want to run as root
RUN addgroup --gid 1024 jupyter
RUN adduser --system --shell /bin/bash --gecos '' --disabled-password --home /home/ubuntu ubuntu
RUN adduser ubuntu jupyter
USER ubuntu
WORKDIR /home/ubuntu
RUN /bin/bash -c  'mkdir /home/ubuntu/workspace && \
    chown ubuntu:jupyter /home/ubuntu/workspace'

CMD ["jupyterhub-singleuser"]
