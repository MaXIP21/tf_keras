FROM tensorflow/tensorflow:latest-gpu
MAINTAINER "Peter Bacsai"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y wget ca-certificates \
    build-essential cmake pkg-config \
    libjpeg8-dev libtiff5-dev \
    software-properties-common  \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev \
    libgtk-3-dev \
    libatlas-base-dev gfortran \
    git curl vim python3-dev python3-pip \
    libfreetype6-dev libhdf5-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip && pip3 install tensorflow && \
    pip3 install numpy pandas sklearn matplotlib seaborn jupyter pyyaml h5py && \
    pip3 install pymldb && \
    pip3 install keras --no-deps && \
    pip3 install imutils

ENV NVIDIA_VERSION=440
RUN apt-get update && add-apt-repository -y ppa:graphics-drivers && apt-get update && apt-get install -y nvidia-driver-$NVIDIA_VERSION 

# Install CUDA
RUN apt-get update && apt-get install -y --no-install-recommends \
gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get purge --autoremove -y curl && \
rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 10.2.89

ENV CUDA_PKG_VERSION 10-2=$CUDA_VERSION-1

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-cudart-$CUDA_PKG_VERSION \
	cuda-nvml-dev-$CUDA_PKG_VERSION \
	cuda-compat-10-2 && \
ln -s cuda-10.2 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.2 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411 brand=tesla,driver>=418,driver<419"
# install NVIDIA Driver

RUN ["mkdir", "notebooks"]

# Jupyter and Tensorboard ports
EXPOSE 8888 6006

# Store notebooks in this mounted directory

VOLUME /notebook
WORKDIR /notebook
EXPOSE 8888
CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --NotebookApp.allow_origin='*'
