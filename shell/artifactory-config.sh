#artifactory installation
echo "deb https://jfrog.bintray.com/artifactory-debs xenial main"  | sudo tee -a /etc/apt/sources.list
curl https://bintray.com/user/downloadSubjectPublicKey?username=jfrog | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y jfrog-artifactory-oss
sudo service artifactory start