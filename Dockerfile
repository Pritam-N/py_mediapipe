FROM --platform=arm64 nvidia/cuda:10.1-cudnn8-devel-ubuntu18.04

RUN apt update && apt install -y python3-dev python3-pip protobuf-compiler cmake git npm

RUN python3 -m pip install --upgrade pip

RUN npm install -g @bazel/bazelisk

# if using this file seaprately then pull the repo and point to the folder
# git clone https://github.com/Pritam-N/py_mediapipe.git
# WORKDIR py_mediapipe/mediapipe

WORKDIR /mediapipe

RUN apt install -y libopencv-core-dev libopencv-highgui-dev \
                        libopencv-calib3d-dev libopencv-features2d-dev \
                        libopencv-imgproc-dev libopencv-video-dev

RUN chmod +x ./setup_opencv.sh

RUN ./setup_opencv.sh

RUN python3 -m pip install -r requirements.txt

RUN python3 setup.py gen_protos

RUN python3 setup.py install --link-opencv