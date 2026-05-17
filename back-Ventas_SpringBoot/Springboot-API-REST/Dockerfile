# Stage 1: Build (Usa Maven con una imagen válida)
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime (Aquí estaba el error)
# Reemplaza openjdk:17-jdk-slim por esta de abajo:
FROM eclipse-temurin:17-jre-alpine 
WORKDIR /app

# Crear usuario no root (Esto te da puntos en el IE1)
RUN addgroup -S spring && adduser -S spring -G spring
USER spring

# Ajusta el nombre de tu .jar según corresponda
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]