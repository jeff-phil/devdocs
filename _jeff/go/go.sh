#!/bin/bash

docker build -t godoc-server .
docker run --rm -p 6060:6060 godoc-server
