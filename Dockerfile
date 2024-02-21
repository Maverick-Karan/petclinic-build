FROM openjdk:17-oracle

RUN mkdir -p /home/petclinic

COPY target/*.jar /home/petclinic/

WORKDIR /home/petclinic/

EXPOSE 8080

CMD ["tail", "-f", "/dev/null"]
