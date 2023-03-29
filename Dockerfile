# build stage
FROM python:3.11-alpine as builder

RUN apk add --no-cache unixodbc-dev unixodbc sqlite-dev

WORKDIR /app

COPY requirements requirements
RUN pip3 install -r requirements

COPY . .

# replace with the command to build your application
RUN python app.py build

# final stage
FROM python:3.11-alpine

RUN apk add --no-cache unixodbc unixodbc-dev sqlite sqlite-dev

WORKDIR /app

# copy your application from the build container
COPY --from=builder /app /app

CMD [ "python", "-m", "flask", "run", "--host=0.0.0.0"]