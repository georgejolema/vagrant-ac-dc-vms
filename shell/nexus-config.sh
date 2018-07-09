wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar xf latest-unix.tar.gz -C /opt
sudo mv nexus.service /etc/systemd/system/
#create users
sudo mkdir /home/nexus
sudo useradd -G sudo -d /home/nexus nexus
sudo usermod -aG sudo nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo chown -R nexus:nexus /home/nexus
#configuring env variables
NEXUS_FOLDER=$(ls /opt | grep nexus)
sudo mv /opt/$NEXUS_FOLDER /opt/nexus
sudo sed -i 's/# INSTALL4J_JAVA_HOME_OVERRIDE=/INSTALL4J_JAVA_HOME_OVERRIDE=\/usr\/lib\/jvm\/java-8-oracle/g' /opt/nexus/bin/nexus
echo 'NEXUS_HOME="/opt/nexus/"' | sudo tee -a ~/.bashrc
source ~/.bashrc
#configuring services
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
echo '' | sudo tee -a /opt/nexus/bin/nexus.rc
echo 'run_as_user="nexus"' | sudo tee -a /opt/nexus/bin/nexus.rc
sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service