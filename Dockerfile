FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git

COPY ./hello $GOPATH/src/hello
WORKDIR $GOPATH/src/hello

RUN go get -d -v
RUN go build -o /go/bin/hello

FROM scratch

COPY --from=builder /go/bin/hello /go/bin/hello

ENTRYPOINT ["/go/bin/hello"]