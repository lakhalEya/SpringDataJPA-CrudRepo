
FROM adoptopenjdk:11-jre-hotspot
WORKDIR /app
COPY target/*.jar .
CMD ["java", "-jar", "exam.jar"]
