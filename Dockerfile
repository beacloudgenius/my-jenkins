FROM jenkins/jenkins:lts
USER root
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install \
            vim \
            certbot \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg2 \
            software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -  && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install google-cloud-sdk


RUN apt install -y python3-pip
RUN pip3 install awscli --upgrade --user
RUN echo "export PATH=/root/.local/bin:$PATH" >> /root/.bashrc

RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
RUN echo "deb https://deb.nodesource.com/node_12.x stretch main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN echo "deb-src https://deb.nodesource.com/node_12.x stretch main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install -y nodejs
