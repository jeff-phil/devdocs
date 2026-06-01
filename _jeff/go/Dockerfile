### See: devdocs/lib/docs/scrapers/go.rb
FROM alpine:latest

RUN apk add --no-cache curl tar

WORKDIR /root

RUN curl -LO https://go.dev/dl/go1.26.0.linux-amd64.tar.gz \
    && tar xf go1.26.0.linux-amd64.tar.gz

ENV PATH="/root/go/bin:/root/go/bin:/root/go/bin:${PATH}"
ENV GOROOT=/root/go
ENV GOPATH=/root/gopath

RUN mkdir -p "${GOPATH}" \
    && /root/go/bin/go install golang.org/x/tools/cmd/godoc@latest

EXPOSE 6060

CMD ["/root/gopath/bin/godoc", "-http", "0.0.0.0:6060", "-v"]
