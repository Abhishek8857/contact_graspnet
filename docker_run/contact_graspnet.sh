#!/bin/bash

SCRIPT_DIR="$(dirname $(readlink -f $0))"
REPO_DIR="$(realpath "${SCRIPT_DIR}/..")"
PARENT_DIR="$(realpath "${REPO_DIR}/..")"
IMAGE_NAME=$(cat "${REPO_DIR}/image_name.cfg")


xhost +local:root

docker run \
    -it \
    --rm \
    --net=host \
    --pid=host \
    --ipc=host \
    --privileged \
    --gpus all \
    --name contact-graspnet-inference \
    --runtime=nvidia \
    -e "ACCEPT_EULA=Y" \
    -e "PRIVACY_CONSENT=Y" \
    -e DISPLAY=$DISPLAY \
    -e NVIDIA_DRIVER_CAPABILITIES=all \
    -e QT_X11_NO_MITSHM=1 \
    --name contact_graspnet \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
    -v $PARENT_DIR:/root/workspaces/:rw \
    -v /dev:/dev \
    -v "$REPO_DIR:/contact_graspnet:rw" \
    -w /contact_graspnet \
    $IMAGE_NAME \
    bash -c "bash watch_and_process.sh && bash"
