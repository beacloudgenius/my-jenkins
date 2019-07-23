docker build -t cloudgenius/jenkins-withdocker:lts .

docker-compose exec cicd cat /var/jenkins_home/secrets/initialAdminPassword

docker-compose exec cicd bash

apt update && apt install -y certbot

certbot certonly -n --standalone -m nilesh@cloudgeni.us --agree-tos --preferred-challenges http -d cicd.cloudgeni.us

    cd /etc/letsencrypt/live/cicd.cloudgeni.us
    cp /etc/letsencrypt/live/cicd.cloudgeni.us/* .
    openssl rsa -in privkey.pem -out privkey-rsa.pem
    java -jar /usr/share/jenkins/jenkins.war  \
        --httpsPort=443 \
        --httpPort=-1 \
        --httpsCertificate=fullchain.pem \
        --httpsPrivateKey=privkey-rsa.pem

https://github.com/hughperkins/howto-jenkins-ssl/blob/master/letsencrypt.md

ALT FORMAT

openssl pkcs12 -inkey privkey.pem -in cert.pem -export -out keys.pkcs12

keytool -importkeystore -srckeystore keys.pkcs12 -srcstoretype pkcs12 -destkeystore /var/lib/jenkins/jenkins.jks

vi /etc/default/jenkins

JENKINS_ARGS="--webroot=/var/cache/\$NAME/war --httpPort=-1 --httpsPort=8443 --httpsKeyStore=/var/lib/jenkins/jenkins.jks --httpsKeyStorePassword=PASSWORD_SET_ON_CONVERT_TO_JKS"

docker-compose restart
