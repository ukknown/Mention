FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/topic-service-1.0.jar TopicService.jar
ENTRYPOINT ["java","-jar","TopicService.jar" ]