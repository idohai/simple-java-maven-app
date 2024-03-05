# Stage 1: Build the application
FROM maven:3.9.6 AS builder
WORKDIR /app
COPY . /app
RUN mvn clean package

# Stage 2: Create the final image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/ .
EXPOSE 8080
CMD ["java", "-jar", "my-app-1.0.0.jar"]