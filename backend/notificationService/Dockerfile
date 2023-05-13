FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/mention-service-1.0.jar NotificationService.jar
ENTRYPOINT ["java","-jar","NotificationService.jar" ]