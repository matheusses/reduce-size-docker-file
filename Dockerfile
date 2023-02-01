## Build
FROM golang:1.16-alpine AS builder

WORKDIR /app

COPY . ./

RUN go mod download && go mod verify

RUN CGO_ENABLED=0 go build -ldflags "-s -w" -o app .

## Deploy
FROM scratch
WORKDIR /root/
COPY --from=builder /app .
CMD ["./app"]