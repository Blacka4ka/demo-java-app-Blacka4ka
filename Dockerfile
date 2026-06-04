# ===== Build stage =====
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

# копіюємо файли проєкту
COPY . .

# збираємо jar через Maven Wrapper (твій випадок)
RUN ./mvnw clean package -DskipTests

# ===== Run stage =====
FROM eclipse-temurin:17-jre

WORKDIR /app

# беремо тільки готовий jar з build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
