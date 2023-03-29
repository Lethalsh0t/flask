# base image
FROM python:3.11

# set working directory
WORKDIR /app

# install dependencies
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# install ODBC driver and SQLite3
RUN apt-get update && apt-get install -y unixodbc-dev unixodbc sqlite3 libsqlite3-dev

# copy app files
COPY . .

# set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# start app
CMD ["flask", "run"]