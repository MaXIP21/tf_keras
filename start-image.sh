#!/bin/bash
_VERSION=$1
_DATE=`date '+%Y-%m-%d'`
if [ -z "$_VERSION" ]
then
docker run --gpus all -d -p 8888:8888 -e KERAS_BACKEND=tensorflow -v /notebook:/notebook tf_keras_$_DATE
else
docker run --gpus all -d -p 8888:8888 -e KERAS_BACKEND=tensorflow -v /notebook:/notebook tf_keras_$_VERSION
fi
