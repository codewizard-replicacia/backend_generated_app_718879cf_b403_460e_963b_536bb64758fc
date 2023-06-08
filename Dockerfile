FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY pom.xml pom.xml
COPY jpa jpa
COPY generated_app_parent generated_app_parent
RUN mvn clean package -DnoTest=true

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/generated_app_parent/target/generated_app_parent-0.0.1-SNAPSHOT.jar /app
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar generated_app_parent-0.0.1-SNAPSHOT.jar"]