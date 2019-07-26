    docker build -t cloudgenius/jenkins-withdocker:lts .

    docker-compose -f docker-compose-nginx-proxy.yaml  up

    docker-compose exec cicd cat /var/jenkins_home/secrets/initialAdminPassword

    docker-compose exec cicd bash

github connection

system wide
personal access token

per repo
username/pass

# Get config

    gcloud container clusters get-credentials andromeda --zone us-west1-a --project oceanic-isotope-233522

# Read the config

    check path in config

# upload config to cloud shell using scp

    gcloud beta compute --project "oceanic-isotope-233522" scp --zone "us-west1-a" ~/config kk://home/eeshan/config

# gcloud login in the jenkins runner container

    gcloud auth login
    gcloud config set project oceanic-isotope-233522

# connect to the host machine

    gcloud beta compute --project "oceanic-isotope-233522" ssh --zone "us-west1-a" "kk"



    export KUBECONFIG=/kube/config
    alias k=kubectl

https://github.com/beacloudgenius/my-jenkins

// agent:
// enabled: true
// image: "cloudgenius/jnlp-slave-with-docker-helm-kubectl"
// tag: "latest"

https://github.com/mattsauce/jenkins-slave-helm-kubectl-docker/blob/master/Dockerfile
https://github.com/korekontrol/docker-jnlp-slave-docker
https://github.com/dtzar/jnlp-slave-helm/blob/master/Dockerfile
https://github.com/jorgeacetozi/jenkins-slave-kubectl-docker-image/blob/master/Dockerfile

https://www.youtube.com/watch?v=xzbMHj1ly9c
https://github.com/davidcurrie/index2018
https://www.slideshare.net/davidcurrie/continuous-delivery-to-kubernetes-with-jenkins-and-helm

https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes
https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes/blob/master/sample-app/Jenkinsfile#L7
https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes/issues/95
