# -------- Stage 1: Build with Maven ----------
FROM maven:3.9.2-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy Maven config and sources
COPY pom.xml .
COPY src ./src

# Build the application JAR (skip tests for speed if you want)
RUN mvn clean package -DskipTests

# -------- Stage 2: Runtime image with JDK ----------
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080 (default Spring Boot port)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
