# -------- Stage 1: Build with Maven ----------
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# 1️⃣ Copy only pom.xml first (better caching)
COPY pom.xml .

# 2️⃣ Download dependencies first (prevents random failures)
RUN mvn -B -Djava.net.preferIPv4Stack=true dependency:go-offline

# 3️⃣ Now copy source code
COPY src ./src

# 4️⃣ Build the application
RUN mvn -B -Djava.net.preferIPv4Stack=true clean package -DskipTests

# -------- Stage 2: Runtime image ----------
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
