#!/bin/bash

yum -y install git gcc make zlib-devel pcre-devel openssl-devel readline-devel

if [[ ! -d /tmp/nginx-installer ]]; then
    git clone https://github.com/dianyong/nginx-installer.git /tmp/nginx-installer
    cd /tmp/nginx-installer
else
    cd /tmp/nginx-installer
    git pull
fi

cd resources
tar xvf ngx_openresty-1.7.7.1.tar.gz
cd ngx_openresty-1.7.7.1
./configure
gmake
gmake install
cd ..
rm -rf ngx_openresty-1.7.7.1
cp -f nginx.conf /usr/local/openresty/nginx/conf/
cp -f proxy.conf /usr/local/openresty/nginx/conf/

killall -0 nginx
if [[ $? -eq 0 ]]; then
    /usr/local/openresty/nginx/sbin/nginx -s reload
else
    /usr/local/openresty/nginx/sbin/nginx
fi
