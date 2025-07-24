# Use a base image with Java and Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy plugin source code
COPY . .

# Build the plugin (HPI)
RUN mvn clean install

# --- Optional: You can stop here if you just want the HPI file ---
# Or move it to a runtime Jenkins image
FROM jenkins/jenkins:lts

# Copy the built plugin to Jenkins plugin directory
COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# Expose default Jenkins port
EXPOSE 8080

# Run Jenkins
CMD ["jenkins"]
