# Java springboot com maven
FROM maven:3.6.3-openjdk-11 AS environment-java

LABEL description="environment-java"

LABEL org.opencontainers.image.name="environment-v"
LABEL org.opencontainers.image.authors="lucasfrct@gmail.com"
LABEL org.opencontainers.image.hostname="environment-java"

LABEL com.docker.volume.name='environment-java'
LABEL com.docker.network.bridge.name='environment-java'

## diretorio de trabalho
WORKDIR /usr/environment-java

## copia o projeto
COPY pom.xml ./
COPY . .

## instala os pacotes
RUN mvn package

## alterar permissóes par ao formato linux
RUN find . -type f -print0 | xargs -0 sed -i 's/\r$//'
RUN find . -type d -print0 | xargs -0 chmod 755  
RUN find . -type f -print0 | xargs -0 chmod 644
# RUN chmod -R +x *.java
# RUN chmod -R +x *.class
# RUN chmod -R +x *.jar

## diretorio padrao
VOLUME /usr/environment-java

EXPOSE 8080
EXPOSE 35729

CMD [ "mvn", "spring-boot:run" ]
