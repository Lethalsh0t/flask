FROM python:3.11-slim-buster

WORKDIR /app

COPY requirements requirements

RUN apt-get update \
    && apt-get -y install unixodbc-dev \
    && pip install --no-cache-dir -r requirements

COPY . .

CMD ["python", "app.py"]