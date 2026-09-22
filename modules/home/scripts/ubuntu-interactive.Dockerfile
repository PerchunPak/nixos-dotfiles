FROM ubuntu:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
      sudo \
      curl \
      wget \
      git \
      vim \
      less \
      man-db \
      procps \
      dnsutils \
      ca-certificates \
      build-essential

RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu

USER ubuntu
WORKDIR /home/ubuntu

CMD ["/bin/bash"]
