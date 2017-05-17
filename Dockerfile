FROM ruby:latest

RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    curl \
    lxc \
    wget \
    vim \
    git \
    software-properties-common \
    iptables && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && apt-get install docker-ce -y && \
    rm -rf /var/lib/apt/lists/*

ADD dockersetup /usr/local/bin/dockersetup
RUN chmod +x /usr/local/bin/dockersetup
VOLUME /var/lib/docker

ADD https://packages.chef.io/files/stable/chefdk/1.3.43/ubuntu/14.04/chefdk_1.3.43-1_amd64.deb chefdk_1.3.43-1_amd64.deb
RUN dpkg -i chefdk_1.3.43-1_amd64.deb

RUN gem install bundler
