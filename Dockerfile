FROM openjdk:17-oracle

RUN mkdir -p /home/petclinic

COPY target/*.jar /home/petclinic/pet-app.jar

WORKDIR /home/petclinic/

EXPOSE 8080

CMD ["java", "-jar", "pet-app.jar"]
