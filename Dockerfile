FROM python:3.11

WORKDIR /app

COPY requirements requirements
RUN pip3 install -r requirements
RUN apt-get update && apt-get install -y unixodbc-dev unixodbc sqlite3 libsqlite3-dev sqliteodbc

COPY . .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]