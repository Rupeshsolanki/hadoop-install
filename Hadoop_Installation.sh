RED='\033[0;32m'  
NC='\033[0m'
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
if dpkg -S /bin/ls >/dev/null 2>&1
then
  sudo apt-get update -y ;
  sudo apt-get install default-jdk -y ;
  cd ;
  wget http://apachemirror.wuchna.com/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz ;
  wget http://apachemirror.wuchna.com/hadoop/common/hadoop-2.7.7/hadoop-2.7.7-src.tar.gz ;
  sudo tar -zxvf hadoop-2.7.7.tar.gz -C /opt ;
  sed -i 's/export JAVA_HOME/#/g' /opt/hadoop-2.7.7/etc/hadoop/hadoop-env.sh ;
  echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" >> /opt/hadoop-2.7.7/etc/hadoop/hadoop-env.sh ;
  echo "export PATH=/opt/hadoop-2.7.7/bin:$PATH" | sudo tee -a /etc/profile ; 
  source /etc/profile ;
  mkdir ~/source ;
  sudo cp /opt/hadoop-2.7.7/etc/hadoop/*.xml ~/source ;
  hadoop jar /opt/hadoop-2.7.7/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.7.jar grep ~/source ~/output 'principal[.]*' ;
  cat ~/output/* ;
  printf "${RED}HADOOP INSTALLATION COMPLETED !\n" ;
  hadoop version ;
  source /etc/profile ;
  printf "${RED}PLEASE RUN THE FINAL COMMAND GIVEN BELOW . . . and then !${NC} Verify by: hadoop version \n" ;
  printf " ############# \n ${RED}source /etc/profile \n ${NC}############ \n" 
elif rpm -q -f /bin/ls >/dev/null 2>&1
then
  sudo yum install epel-release -y ;
  sudo yum update -y ;
  sudo yum install -y java-1.8.0-openjdk ;
  cd ;
  yum install wget -y ;
  wget http://apachemirror.wuchna.com/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz ;
  wget http://apachemirror.wuchna.com/hadoop/common/hadoop-2.7.7/hadoop-2.7.7-src.tar.gz ;
  sudo yum install perl-Digest-SHA -y ;
  sudo tar -zxvf hadoop-2.7.7.tar.gz -C /opt ;
  sed -i 's/export JAVA_HOME/#/g' /opt/hadoop-2.7.7/etc/hadoop/hadoop-env.sh ;
  echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" >> /opt/hadoop-2.7.7/etc/hadoop/hadoop-env.sh ;
  echo "export PATH=/opt/hadoop-2.7.7/bin:$PATH" | sudo tee -a /etc/profile ; 
  source /etc/profile ;
  mkdir ~/source ;
  cp /opt/hadoop-2.7.7/etc/hadoop/*.xml ~/source ;
  hadoop jar /opt/hadoop-2.7.7/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.7.jar grep ~/source ~/output 'principal[.]*' ;
  cat ~/output/* ;
  printf "${RED}HADOOP INSTALLATION COMPLETED !\n" ;
  hadoop version
  printf "${RED}PLEASE RUN THE FINAL COMMAND GIVEN BELOW . . . and then !${NC} Verify by: hadoop version \n" ;
  printf " ########### \n ${RED}source /etc/profile \n ${NC}########## \n"
 else
  echo "Don't know this package system (neither RPM nor DEB)."
  exit 1
fi
