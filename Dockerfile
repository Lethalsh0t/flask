# build stage
FROM python:3.11 as builder

WORKDIR /app

COPY requirements requirements
RUN pip3 install -r requirements
RUN apt-get update && apt-get install -y unixodbc-dev unixodbc sqlite3 libsqlite3-dev

COPY . .

# replace with the command to build your application
RUN python app.py build

# final stage
FROM python:3.11-alpine

WORKDIR /app

# copy your application from the build container
COPY --from=builder /app /app

CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0"]