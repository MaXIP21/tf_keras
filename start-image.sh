#!/bin/bash
_VERSION=$1
case $_VERSION in
  main)
    _name="tf_keras"
	docker run --gpus all -d -p 8888:8888 -e KERAS_BACKEND=tensorflow -v /notebook:/notebook $_name
    ;;

  today)
    _DATE=`date '+%Y-%m-%d'`
    _name="tf_keras"_$_DATE
    echo "Running image : $_name ..."
	docker run --gpus all -d -p 8888:8888 -e KERAS_BACKEND=tensorflow -v /notebook:/notebook $_name
    ;;
  date)
    _DATE=$2
    if [ -z "$_DATE" ]
    then
	echo "error: date missing exiting.."
    else
    _name="tf_keras"_$_DATE
	docker run --gpus all -d -p 8888:8888 -e KERAS_BACKEND=tensorflow -v /notebook:/notebook $_name
    fi
    ;;

  *)
    echo "usage: start.sh [options] [options]
  options:
     today 	starts image built today.
     main 	starts the main image.
     date	start the image with the specified date expects the date a second variable eg: start date 2020-03-03

     please use one of the options to execute!"
    ;;
esac

