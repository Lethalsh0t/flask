# build stage
FROM python:3.11 as builder

WORKDIR /app

COPY requirements requirements
RUN pip3 install -r requirements
RUN apt-get update && apt-get install -y unixodbc-dev unixodbc sqlite3 libsqliteodbc

# copy SQLite3 ODBC driver shared library file to /usr/lib/x86_64-linux-gnu
COPY sqlite3odbc/libsqlite3odbc.so /usr/lib/x86_64-linux-gnu/

COPY . .

# replace with the command to build your application
RUN python app.py build

# final stage
FROM python:3.11-alpine

WORKDIR /app

# copy your application from the build container
COPY --from=builder /app /app

CMD [ "python", "-m", "flask", "run", "--host=0.0.0.0"]