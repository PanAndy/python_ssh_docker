#!/usr/bin/env bash

# 进行docker镜像打包
docker build -f .Dockerfile -t yalixiong/centos:ssh_base .

docker push yalixiong/centos:ssh_base
