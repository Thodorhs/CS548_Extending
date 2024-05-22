# Dockerfile
FROM python:3.9-slim

RUN mkdir -p /app/tmp
RUN apt-get update && \
    apt-get upgrade -y && \ 
    apt-get install curl -y && \ 
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \ 
    chmod +x kubectl && \ 
    mv ./kubectl /usr/local/bin

COPY requirements.txt kubeclient.py controller.py /app/
WORKDIR /app

RUN pip install -r requirements.txt

CMD ["python3", "controller.py"]

