# ===== Build stage =====
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

# копіюємо файли проєкту
COPY . .

# збираємо через Gradle
RUN chmod +x gradlew
RUN ./gradlew clean bootJar --no-daemon

# ===== Run stage =====
FROM eclipse-temurin:17-jre

WORKDIR /app

# беремо тільки готовий jar з build stage
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]

