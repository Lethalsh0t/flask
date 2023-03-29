FROM python:3.11-slim-buster

ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/odbc/:$LD_LIBRARY_PATH

WORKDIR /app

COPY requirements requirements

RUN apt-get update \
    && apt-get -y install unixodbc-dev \
    && pip install --no-cache-dir -r requirements

COPY . .

CMD ["python", "app.py"]