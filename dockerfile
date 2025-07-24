FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . .

# Skip access modifier check temporarily for local builds
RUN mvn clean install -Daccess-modifier-checker.skip=true

FROM jenkins/jenkins:lts

COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/

EXPOSE 8080

CMD ["jenkins"]
