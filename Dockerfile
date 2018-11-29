FROM openhorizon/aarch64-tx2-cudabase

MAINTAINER Mike Lane <mikelane@gmail.com>

# Install python and pip
RUN apt-get update && apt-get install -y \
  python3-pip \ 
  python3-dev \
  python3-numpy \
  python3-wheel 

# Install TF-gpu 1.5 with python3
RUN pip3 install --upgrade \
  pip \
  setuptools \
  https://github.com/frankgu968/installTensorFlowTX2/raw/master/whl/tensorflow-1.5.0-cp35-cp35m-linux_aarch64.whl

# Pillow dependencies
RUN apt-get install -y libblas-dev \
  liblapack-dev \
  libjpeg-dev \
  libgtk2.0-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  libpng-dev \
  python3-matplotlib \
  zlib1g-dev

### Keras dependencies
RUN pip3 install --no-cache-dir --upgrade \
  graphviz \
  pydot \
  pandas \
  Pillow \
  pyzmq==17.0.0 \  # SEE: https://shiroku.net/robotics/install-jupyter-notebook-on-jetson-tx2/
  jupyter \
  jupyterlab
RUN export CC=h5cc
RUN HDF5_DIR=/usr/lib/aarch64-linux-gnu/hdf5/serial/ pip3 install --no-cache-dir h5py

# Install scipy, keras
RUN pip3 install --no-cache-dir --upgrade \
  scipy \
  keras \
  scikit-learn \
  scikit-image

## Clean up (remove ~6GB space)
RUN rm -rf /var/cuda-repo-9-0-local/*.deb
RUN rm -rf /usr/local/cuda-9.0/doc/*
RUN rm -rf /root/src/jetsonhacks
RUN mv /usr/local/cuda-9.0/samples/2_Graphics/ /usr/local/cuda-9.0/
RUN rm -rf /usr/local/cuda-9.0/samples/*
RUN mv /usr/local/cuda-9.0/2_Graphics/ /usr/local/cuda-9.0/samples/

CMD jupyter lab --port=8888 --ip=* --notebook-dir=/data --no-browser --allow-root
