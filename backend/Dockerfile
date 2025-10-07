# ---------- Build Stage ----------
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

# نسخ ملف pom.xml وتحميل الاعتمادات
COPY pom.xml .
RUN mvn -q -e -B -DskipTests dependency:go-offline

# نسخ الكود وبناؤه
COPY src ./src
RUN mvn -q -e -B -DskipTests clean package

# ---------- Runtime Stage ----------
FROM eclipse-temurin:21-jre
WORKDIR /app

# ضبط إعدادات Spring Boot ليستمع على جميع العناوين
ENV SPRING_PROFILES_ACTIVE=docker
ENV SERVER_ADDRESS=0.0.0.0

# نسخ ملف JAR النهائي
COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]

