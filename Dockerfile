# syntax=docker/dockerfile:1
FROM openjdk:8-alpine

EXPOSE 8070

ENV APP_PORT=8070

COPY ./user-microservice/target/user-microservice-0.1.0.jar user.jar

ENTRYPOINT ["java", "-jar", "user.jar"]
