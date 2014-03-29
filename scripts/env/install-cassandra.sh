#!/usr/bin/env bash

function error {
  printf "\e[31m$1\n\033[0m"
}
function info {
  printf "\e[32m$1\n\033[0m"
}


ORIGIN_DIR=$(pwd)
VERSION=2.0.6
ROOT_DIR=/usr/local

info "Download Cassandra..."
wget http://www.us.apache.org/dist/cassandra/$VERSION/apache-cassandra-$VERSION-bin.tar.gz
tar xzf apache-cassandra-$VERSION-bin.tar.gz
rm apache-cassandra-$VERSION-bin.tar.gz
info "done"

info "Preparing for Cassandra installation..."
sudo rm -r $ROOT_DIR/apache-cassandra-$VERSION
sudo mkdir -p $ROOT_DIR
info "done"


info "Moving cassandra to $ROOT_DIR..."
sudo mv apache-cassandra-$VERSION $ROOT_DIR
sudo ln -sfn $ROOT_DIR/apache-cassandra-$VERSION $ROOT_DIR/cassandra
info "done"


info "Creating paths..."
sudo mkdir -p /var/log/cassandra
sudo chown -R $USER /var/log/cassandra
sudo mkdir -p /var/lib/cassandra
sudo chown -R $USER /var/lib/cassandra
info "done"


info "Exporting cassandra to path..."
echo "export PATH=$ROOT_DIR/cassandra/bin:\$PATH" >> ~/.bash_profile
source ~/.bash_profile
info "done"




info "Cleaning up..."
cd $ORIGIN_DIR
if [ -d apache-cassandra-$VERSION  ]; then
  rm -r apache-cassandra-$VERSION
fi
info "...done"

info "Start Cassandra with the following command 'cassandra -f'"
