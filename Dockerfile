FROM maven:3.6.3-jdk-11 as mavenbuilder
ARG LOC=/home/project
WORKDIR $LOC
COPY . .
RUN mvn clean package

FROM tomcat:9.0
ARG LOC=/home/project
COPY --from=mavenbuilder ${LOC}/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
