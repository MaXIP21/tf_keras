# tf_keras repository for Tensorflow Docker image build

The Docker fiel contains all the necessary steps to create your own Tensorflow image including the followings:

  - numpy 
  - pandas 
  - sklearn 
  - matplotlib 
  - seaborn 
  - jupyter 
  - pyyaml 
  - h5py
  - pymldb # MLDB for python
  
The installation contains the Nvidia driver version 440 and Cuda version 10.2

The additional scripts:
  - build-today.sh // Build the image with the current date tag YYYY-MM-DD format
  - start-image.sh <YYYY-MM-DD> // starts the selected image adding all the GPU resources
