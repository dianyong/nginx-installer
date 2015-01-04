#!/bin/bash

yum -y install git gcc make zlib-devel pcre-devel openssl-devel readline-devel

if [[ ! -d /tmp/nginx-installer ]]; then
    git clone https://github.com/xifeng/nginx-installer.git /tmp/nginx-installer
    cd /tmp/nginx-installer
else
    cd /tmp/nginx-installer
    git fetch
fi

cd resources
tar xvf ngx_openresty-1.7.7.1.tar.gz
cd ngx_openresty-1.7.7.1
./configure
gmake
gmake install
cd ..
rm -rf ngx_openresty-1.7.7.1
cp -f conf/nginx.conf /usr/local/openresty/nginx/conf/
cp -f conf/proxy.conf /usr/local/openresty/nginx/conf/

/usr/local/openresty/nginx/bin/nginx
