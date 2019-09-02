# Set up a fedora 30 server on Chromebox

# connect to the machine

    ssh chromebox

# update and install git

    sudo dnf install -y git-core

# clone the repo

    git clone https://github.com/beacloudgenius/my-jenkins.git
    cd my-jenkins

# setup docker on chromebox

    sudo su
    sh docker.sh
    exit # from root

    sudo usermod -aG docker $USER
    newgrp docker

# Get config

    rm -rf ~/.kube
    gcloud container clusters get-credentials andromeda --zone us-west1-a --project oceanic-isotope-233522

# Read the config

    check path in config

# upload config to the vm using scp

    gcloud beta compute --project "oceanic-isotope-233522" scp --zone "us-west1-a" ~/.kube/config kk://home/eeshan/

# connect back to the vm again to allow for docker without the need to run sudo

    gcloud beta compute --project "oceanic-isotope-233522" ssh --zone "us-west1-a" "kk"

# place config in ~/.kube/config

    mkdir ~/.kube
    mv ~/config ~/.kube

    cd ~/my-jenkins/

# run the jenkins runner using docker-compose

    docker-compose up -d

# grab jenkins initial admin password

wait for 1 minute and

    docker-compose exec cicd cat /var/jenkins_home/secrets/initialAdminPassword

# open https://cicd.home.cloudgeni.us in a browser

    finish through the user creation process

# access the cicd runner

    cd ~/my-jenkins
    docker-compose exec cicd bash

# set up gcloud login and verify kubeconfig

#### account for gloud bin location

    mkdir -p /google/google-cloud-sdk/bin/
    ln -s /usr/bin/gcloud /google/google-cloud-sdk/bin/

PS: location of gcloud in shell (/google/google-cloud-sdk/bin/) is different from the standard (/usr/bin) in the jenkins runner

### in the jenkins runner container

    gcloud auth login

    follow instructions on the terminal

    gcloud config set project oceanic-isotope-233522

    # export KUBECONFIG=/kube/config
    alias k=kubectl

# github connection

    system wide using a personal access token

    per repo using username/pass
