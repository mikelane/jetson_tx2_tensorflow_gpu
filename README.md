# Dockerfile for GPU-accelerated Tensorflow 1.5 on NVIDIA Jetson TX2
---

This repo contains the Dockerfile you need to set up Keras with a Tensorflow-gpu v1.5 backend using python 3.5. This includes other machine learning libraries such as Scikit-Learn, Scikit-Image, Numpy, Pandas, Matplotlib, Scipy, etc. (Note Anaconda isn't available on ARM). 

## Pre-requisites

You will first need to install JetPack 3.2 from https://developer.nvidia.com/embedded/jetpack. This should get you set up with Cuda 9, cuDNN 7, and the other requirements you'll need to take advantage of the GPU. 

Second, you need to go install Tegra-Docker from https://github.com/Technica-Corporation/Tegra-Docker. Follow the instructions from your TX2 to ensure that the `tx2-docker` wrapper has access to the GPU.

## Running

This repo comes with a Makefile. All you need to do to build a gpu-accelerated Jupyter Lab is to change to the directory that includes the Dockerfile and do 

    make notebook GPU=0

Building the docker container takes quite a while, but once it completes, a Jupyter Lab server will start and you'll be given a web address. Go to that web address (you may have to replace localhost with the local IP address of your TX2 if you're ssh'd in, but doing so should just work because of how everything is set up) and start building your machine learning application right on your TX2.
