#!/bin/bash
_DATE=`date '+%Y-%m-%d'`
_name="tf_keras"_$_DATE
echo "BUILDING : $_name"
docker build -f Dockerfile -t "$_name" .
