# build stage
FROM python:3.11 as builder

WORKDIR /app

COPY requirements requirements
RUN pip3 install -r requirements
RUN apt-get update && apt-get install -y unixodbc-dev unixodbc sqlite3 libsqlite3-dev

COPY . .

# replace with the command to build your application
RUN python setup.py build

# final stage
FROM mcr.microsoft.com/windows/nanoserver:1809

WORKDIR /app

# copy your application from the build container
COPY --from=builder /app /app

CMD [ "python.exe", "-m", "flask", "run", "--host=0.0.0.0"]