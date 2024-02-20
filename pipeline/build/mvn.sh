#!/bin/bash

echo "*************************************"
echo "********** Building jar *************"
echo "*************************************"

WORKSPACE=/home/ec2-user/build/jenkins_home/workspace/build

docker run --rm -v $WORKSPACE/petclinic-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3.8-openjdk-18-slim "$@"

cp petclinic-app/target/*.jar pipeline/build/