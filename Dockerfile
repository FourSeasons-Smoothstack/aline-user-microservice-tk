# syntax=docker/dockerfile:1
FROM alpine

RUN apk update && \
    apk add openjdk11-jre

EXPOSE 8070

ENV APP_PORT=8070

COPY user-microservice/target/user-microservice-0.1.0.jar /app
WORKDIR /app

ENTRYPOINT ["java", "-jar", "user-microservice-0.1.0.jar"]
