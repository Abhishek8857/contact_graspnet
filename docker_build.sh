#!/bin/bash
set -e

IMAGE_NAME=$(cat image_name.cfg)

# Build the Docker image and pass the boolean
docker build -t "$IMAGE_NAME" .