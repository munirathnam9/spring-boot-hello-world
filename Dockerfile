# -------- Stage 1: Build with Maven ----------
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# ✅ Add Maven settings
COPY settings.xml /root/.m2/settings.xml

COPY pom.xml .

RUN mvn -B -Djava.net.preferIPv4Stack=true dependency:go-offline

COPY src ./src

RUN mvn -B -Djava.net.preferIPv4Stack=true clean package -DskipTests

# -------- Stage 2: Runtime image ----------
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
