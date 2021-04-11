# Set up a new VM
    named cicd
    size e2-standard-2
    in us-west1-a
    using debian 10 OS image

    allow http https
    note IP address 34.82.225.8
    cicd.cloudgenius.app  = set DNS A record

# connect to the machine

    gcloud beta compute --project "intense-cortex-271814" ssh --zone "us-west1-a" "cicd"

# update and install git

    sudo su
    apt update && apt install -y git
    exit # from root

# clone the repo

    git clone https://github.com/beacloudgenius/my-jenkins.git
    cd my-jenkins

# setup docker on this

    sudo su
    sh docker.sh
    exit # from root

    sudo usermod -aG docker $USER
    exit

# Get config

    rm -rf ~/.kube
    gcloud container clusters get-credentials andromeda --zone us-west1-a --project intense-cortex-271814

# Read the config

    check ~/.kube
    check ~/.config/gcloud

    check cmd-path: in ~/.kube/config

# upload config to the vm using scp

    gcloud beta compute --project "intense-cortex-271814" scp --zone "us-west1-a" ~/.kube/config cicd://home/ubuntu/

# connect back to the vm again to allow for docker without the need to run sudo

    gcloud beta compute --project "intense-cortex-271814" ssh --zone "us-west1-a" "cicd"

# place config in ~/.kube/config

    mkdir ~/.kube
    mv ~/config ~/.kube

    cd ~/my-jenkins/

# edit the docker-compose.yaml to match the subdomain.domain.TLD of your choice

find cicd.cloudgenius.app and replace it your specific detail

    environment:
      - VIRTUAL_HOST=cicd.cloudgenius.app
      - LETSENCRYPT_HOST=cicd.cloudgenius.app

# check secrets in docker-compose.yaml

encode the service account json using base64

    cat svcaccount.json | base64 |  tr -d "\n"


    - GKE_SERVICE_ACCOUNT in docker-compose.yaml to make sure it's valid for k8s cluster
    - D_USER=lvnilesh
    - D_PASS=token get one from dockerhub
    - GH_PAT=token get one from github
    - AWS_ACCESS_KEY_ID=id get one from AWS
    - AWS_SECRET_ACCESS_KEY=secret get one from AWS

# run the jenkins runner using docker-compose

    docker-compose up -d

# grab jenkins initial admin password

wait for 1 minute and

    docker-compose exec cicd cat /var/jenkins_home/secrets/initialAdminPassword

# open https://subdomain.domain.TLD in a browser

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

    gcloud config set project intense-cortex-271814

    # export KUBECONFIG=/kube/config
    alias k=kubectl

# github connection

    system wide using a personal access token

    per repo using username/pass
