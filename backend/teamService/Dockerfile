FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/team-service-1.0.jar TeamService.jar
ENTRYPOINT ["java","-jar","TeamService.jar" ]