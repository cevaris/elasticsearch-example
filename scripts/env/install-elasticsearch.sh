#!/usr/bin/env bash

function error {
  printf "\e[31m$1\n\033[0m"
}
function info {
  printf "\e[32m$1\n\033[0m"
}

ORIGIN_DIR=$(pwd)
VERSION=1.1.0
ROOT_DIR=/usr/local

info "Downloading ElasticSearch...."
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$VERSION.zip
unzip elasticsearch-$VERSION.zip
rm elasticsearch-$VERSION.zip
info "done"

info "Preparing for ElasticSearch installation..."
sudo rm -r $ROOT_DIR/elasticsearch-$VERSION
sudo mkdir -p $ROOT_DIR
info "done"

info "Moving ElasticSearch to $ROOT_DIR..."
sudo mkdir -p /usr/local/
sudo mv elasticsearch-$VERSION $ROOT_DIR
sudo ln -sfn $ROOT_DIR/elasticsearch-$VERSION $ROOT_DIR/elasticsearch
info "done"


info "Exporting ElasticSearch to path..."
echo "export PATH=$ROOT_DIR/elasticsearch/bin:\$PATH" >> ~/.bash_profile
source ~/.bash_profile
info "done"


info "********************************************"
info "Run ElasticSearch with the following command:"
info "elasticsearch"
info "********************************************"

