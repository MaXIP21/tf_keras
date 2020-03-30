#!/bin/bash
_CMD=$1
case $_CMD in
  main)
   _name="tf_keras"
    echo "BUILDING : $_name"
    docker build -f Dockerfile -t "$_name" .
    ;;

  today)
    _DATE=`date '+%Y-%m-%d'`
    _name="tf_keras"_$_DATE
    echo "BUILDING : $_name"
    docker build -f Dockerfile -t "$_name" .
    ;;

  *)
    echo "usage: build.sh [options]
  options:
     today 	Builds image with the date at the end.
     main 	Builds the main image.

     please use one of the options to execute!"
    ;;
esac
