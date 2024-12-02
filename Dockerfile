# Build Stage
FROM maven:3-openjdk-17 AS build
WORKDIR /app

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Build ứng dụng và tạo file JAR
RUN mvn clean package

# Run Stage
FROM openjdk:17-jdk-slim
WORKDIR /app

# Sao chép file JAR từ Build stage vào Run stage
COPY --from=build /app/target/nihongo-0.0.1-SNAPSHOT.jar nihongo.jar

# Mở cổng mà ứng dụng lắng nghe
EXPOSE 8080

# Chạy ứng dụng Spring Boot
ENTRYPOINT ["java", "-jar", "nihongo.jar"]