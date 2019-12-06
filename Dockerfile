FROM golang:alpine as build

RUN apk update && apk add git

RUN go get github.com/alash3al/redix

EXPOSE 6380 7090

ENTRYPOINT ["redix"]

WORKDIR /root/


FROM alpine:latest
ENV APPVERSION=1.10
LABEL VERSION="redix-${APPVERSION}"
LABEL EMAIL="1141519465@qq.com"
LABEL AUTHOR="dalongrong"
WORKDIR /app
ENV ENGINE=leveldb
ENV STORAGE=./redix-data
ENV RESP=:6380
ENV REST=:7090
ENV WORKERS=4
EXPOSE 6380 7090
ENV PATH=$PATH:/usr/local/bin
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
COPY --from=build /root/redix /usr/local/bin/redix
ENTRYPOINT ["./entrypoint.sh"]