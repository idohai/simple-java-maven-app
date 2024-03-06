# Stage 1: Build the application
FROM maven:3.9.6 AS builder

ARG VERSION

WORKDIR /app
COPY . /app

RUN mvn versions:set -DnewVersion=${VERSION}
RUN mvn clean package

# Stage 2: Create the final image
FROM openjdk:11-jre-slim

ARG VERSION
ENV ENV-VERSION ${VERSION}

WORKDIR /app

COPY --from=builder /app/target/ .
EXPOSE 8080
CMD ["java", "-jar", "my-app-${ENV-VERSION}.jar"]