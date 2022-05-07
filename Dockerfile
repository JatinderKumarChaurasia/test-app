ARG BUILD_HOME=/home/myapp/
MAINTAINER Jatinder Kumar Chaurasia

FROM gradle:latest as build-image
ARG BUILD_HOME
ENV APP_HOME=$BUILD_HOME
WORKDIR $APP_HOME
COPY build.gradle settings.gradle $APP_HOME/
COPY src $APP_HOME/src
RUN gradle --no-daemon build

FROM openjdk:19-jdk as run-image
ARG BUILD_HOME
ENV APP_HOME=$BUILD_HOME
COPY --from=build-image $APP_HOME/build/libs/*.jar app.jar
ENTRYPOINT java -jar app.jar
EXPOSE 8080
