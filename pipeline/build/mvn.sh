#!/bin/bash

echo "*************************************"
echo "********** Building jar *************"
echo "*************************************"

#WORKSPACE=/var/lib/jenkins/workspace/build
WORKSPACE=/home/ec2-user/build

docker run --rm -v $WORKSPACE/petclinic-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3.8-openjdk-18-slim "$@"

cp $WORKSPACE/petclinic-app/target/*.jar $WORKSPACE/pipeline/build/