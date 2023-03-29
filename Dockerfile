# Stage 1: Build ODBC driver
FROM debian:buster-slim AS builder

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    automake \
    autoconf \
    libtool \
    pkg-config \
    unixodbc-dev \
    libsqlite3-dev

RUN git clone https://github.com/chriswue/libsqliteodbc.git /tmp/libsqliteodbc
WORKDIR /tmp/libsqliteodbc
RUN ./autogen.sh
RUN ./configure --prefix=/usr --sysconfdir=/etc --disable-readline
RUN make
RUN make install

# Stage 2: Build Flask app
FROM python:3.11

WORKDIR /app

COPY requirements requirements
RUN pip3 install -r requirements

COPY . .

# Copy ODBC driver from builder stage
COPY --from=builder /usr/lib/x86_64-linux-gnu/odbc/libsqlite3odbc.so /usr/lib/x86_64-linux-gnu/odbc/

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
