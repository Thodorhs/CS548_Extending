FROM python:3.9-slim

RUN apt-get update && \
    apt-get upgrade -y

COPY requirements.txt controller.py /app/
WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt

CMD python3 controller.py
