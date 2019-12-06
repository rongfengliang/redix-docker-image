FROM golang:alpine as build
RUN apk update && apk add git
WORKDIR /root/
RUN  git clone https://github.com/alash3al/redix.git
RUN cd redix && go build

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
COPY --from=build /root/redix-docker-image/redix /usr/local/bin/redix
ENTRYPOINT ["./entrypoint.sh"]