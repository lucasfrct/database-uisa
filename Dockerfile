# Java springboot com maven
FROM maven:3.6.3-openjdk-11 AS environment-java

ENV TZ=America/Los_Angeles
ENV NLS_TIMESTAMP_FORMAT='DD/MON/RR HH24:MI:SSXFF'
ENV NLS_LANGUAGE='AMERICAN'
ENV NLS_TERRITORY='AMERICA'
ENV NLS_ISO_CURRENCY='AMERICA'
ENV NLS_NUMERIC_CHARACTERS='.,'
ENV NLS_DATE_FORMAT='DD/MM/YYYY'
ENV NLS_TIME_FORMAT='HH.MI.SSXFF AM'
ENV NLS_TIME_TZ_FORMAT='HH.MI.SSXFF AM TZR'
ENV NLS_TIMESTAMP_TZ_FORMAT='DD-MON-RR HH.MI.SSXFF AM TZR'


LABEL description="environment-java"

LABEL org.opencontainers.image.name="environment-v"
LABEL org.opencontainers.image.authors="lucasfrct@gmail.com"
LABEL org.opencontainers.image.hostname="environment-java"

LABEL com.docker.volume.name='environment-java'
LABEL com.docker.network.bridge.name='environment-java'

## Atulaiza o continer
# RUN lsb_release -a
RUN apt -y update && apt -y upgrade
RUN apt -y install build-essential wget git unzip gcc tzdata
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 
RUN dpkg-reconfigure -f noninteractive tzdata
RUN apt install -y libpq-dev zlib1g-dev shared-mime-info libaio1 libaio-dev --no-install-recommends 
RUN apt -y install alien libaio1 unixodbc

## diretorio de trabalho
WORKDIR /usr/environment-java

## copia o projeto
COPY pom.xml ./
COPY src ./src/

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
