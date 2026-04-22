FROM tensorflow/tensorflow:2.11.1-gpu

RUN apt-get update && apt-get install -y \
    locales \
    curl \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    libqt5gui5 && \
    rm -rf /var/lib/apt/lists/*

COPY . /contact_graspnet

RUN pip3 install --no-cache-dir -r /contact_graspnet/requirements.txt
