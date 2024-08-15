FROM golang:alpine AS builder

WORKDIR /app

COPY /src/* .

ENV BINARY_NAME=dns-updater

RUN go build -o /app/${BINARY_NAME}

FROM alpine:3.20.2

ENV BINARY_NAME=dns-updater

COPY --from=builder /app/${BINARY_NAME} /app/${BINARY_NAME}

RUN chmod 777 /app/${BINARY_NAME}

CMD  /app/${BINARY_NAME}
