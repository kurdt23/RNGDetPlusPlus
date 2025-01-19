FROM pytorch/pytorch:1.8.0-cuda11.1-cudnn8-devel
WORKDIR /tonyxu
RUN set -e && \
    ([ -f /etc/apt/sources.list.d/cuda.list ] && rm /etc/apt/sources.list.d/cuda.list || echo "File not found") && \
    rm -f /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-key del 7fa2af80 && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget

# Копирование необходимых файлов в контейнер
COPY cuda-repo-ubuntu2004-12-6-local_12.6.2-560.35.03-1_amd64.deb /tmp/
COPY cuda-ubuntu2004.pin /tmp/cuda-ubuntu2004.pin

# Настройка репозитория CUDA
RUN mv /tmp/cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    dpkg -i /tmp/cuda-repo-ubuntu2004-12-6-local_12.6.2-560.35.03-1_amd64.deb && \
    cp /var/cuda-repo-ubuntu2004-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && \
    apt-get -y install cuda-toolkit-12-6 && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Установка системных зависимостей
RUN set -e && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-dev \
        build-essential \
        cython \
        gcc \
        libgl1-mesa-dev \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        libgl1-mesa-glx \
        zip \
        git \
        openjdk-8-jdk \
        ant \
        ca-certificates-java \
        golang && \
    apt-get clean && \
    update-ca-certificates -f && \
    rm -rf /var/lib/apt/lists/*

   
COPY requirement.txt requirement.txt
RUN pip install -r requirement.txt && \
    pip install git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI

    
# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
