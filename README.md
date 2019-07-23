docker build -t cloudgenius/jenkins-withdocker:lts .

docker-compose exec cicd cat /var/jenkins_home/secrets/initialAdminPassword

docker-compose exec cicd bash
