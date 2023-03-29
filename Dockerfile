FROM python:3.11-slim-buster

WORKDIR /app

COPY requirements requirements

RUN pip install -r requirements
RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev unixodbc unixodbc-dev unixodbc-bin
RUN apt-get install -y libsqliteodbc
COPY . .

CMD ["python", "app.py"]