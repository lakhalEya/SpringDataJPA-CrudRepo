
FROM adoptopenjdk:11-jre-hotspot
WORKDIR /app
COPY target/exam.jar .
CMD ["java", "-jar", "exam.jar"]
