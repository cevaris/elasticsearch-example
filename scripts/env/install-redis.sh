#!/usr/bin/env bash

function error {
  printf "\e[31m$1\n\033[0m"
}
function info {
  printf "\e[32m$1\n\033[0m"
}

ORIGIN_DIR=$(pwd)
REDIS_VERSION=stable
ROOT_DIR=/usr/local

info "Downloading Redis...."
wget http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz
tar xzf redis-$REDIS_VERSION.tar.gz
rm redis-$REDIS_VERSION.tar.gz
info "done"

info "Preparing for Redis installation..."
sudo rm -r $ROOT_DIR/redis-$REDIS_VERSION
sudo mkdir -p $ROOT_DIR
info "done"

info "Moving Redis to $ROOT_DIR..."
sudo mkdir -p /usr/local/
sudo mv redis-$REDIS_VERSION $ROOT_DIR
sudo ln -sfn $ROOT_DIR/redis-$REDIS_VERSION $ROOT_DIR/redis
info "done"

info "Compiling/Installing Redis..."
cd $ROOT_DIR/src
make
sudo make install
info "done"

info "Exporting Redis to path..."
echo "export PATH=$ROOT_DIR/redis/bin:\$PATH" >> ~/.bash_profile
source ~/.bash_profile
info "done"


info "Cleaning up..."
cd $ORIGIN_DIR
if [ -d redis-$REDIS_VERSION  ]; then
  rm -r redis-$REDIS_VERSION
fi
info "done"



info "********************************************"
info "Run Redis with the following command:"
info "redis-server"
info "********************************************"

