#!/bin/bash

docker build -t "lewissenior/dotcv" .
docker push lewissenior/dotcv:latest
docker image prune
