#FROM maven:3.5-jdk-8-alpine as lib 
#RUN mkdir /app
#COPY lgsp-tb-api/. /app/src
#WORKDIR /app/src

#RUN mvn clean install -Dmaven.test.skip=true
#RUN find /app/src -delete

#-------------------------------

FROM deam2k/log_tthcc_lib:1.0.1 as build

COPY lgsp-tb-api/. /app/src
WORKDIR /app/src

RUN mvn package -Dmaven.test.skip=true


FROM openjdk:8-jre 

RUN mkdir /app
EXPOSE 8091

COPY --from=build /app/src/target/qlvb-tb.jar /app/qlvb-tb.jar
WORKDIR /app
CMD  ["java","-jar", "qlvb-tb.jar" ]