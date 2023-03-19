# Start with a base image that includes the Java Runtime Environment (JRE)
FROM openjdk:17-alpine

# Set the working directory for the application
WORKDIR /home/ubuntu/Springdemo/target

# Copy the JAR file into the container
COPY ./target/spring-petclinic-3.0.0-SNAPSHOT.jar .

# Set the command to run the application when the container starts
CMD ["java", "-jar", "spring-petclinic-3.0.0-SNAPSHOT.jar"]