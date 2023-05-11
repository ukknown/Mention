FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/mention-service-1.0.jar MentionService.jar
ENTRYPOINT ["java","-jar","MentionService.jar" ]