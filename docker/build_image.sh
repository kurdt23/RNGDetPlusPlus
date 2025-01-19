#!/bin/sh
# docker build -t zhxu_1.8.0-cuda11.1-cudnn8_py3.8 .
docker build  --security-opt seccomp=unconfined --network=host -t zhxu_1.8.0-cuda11.1-cudnn8_py3.8 .
