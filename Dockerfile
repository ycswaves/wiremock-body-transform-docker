FROM java:8-jdk

ENV WIREMOCK_VERSION 2.2.2

RUN wget -q https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/${WIREMOCK_VERSION}/wiremock-standalone-$WIREMOCK_VERSION.jar

RUN wget -q https://github.com/opentable/wiremock-body-transformer/releases/download/wiremock-body-transformer-1.1.1/wiremock-body-transformer-1.1.1.jar

RUN useradd wiremock -m
USER wiremock
WORKDIR /home/wiremock

VOLUME /home/wiremock
EXPOSE 8080 8081

CMD java -cp "wiremock-body-transformer-1.1.1.jar" com.opentable.extension.BodyTransformer
CMD java -jar /wiremock-standalone-$WIREMOCK_VERSION.jar $WIREMOCK_ARGS --extensions com.opentable.extension.BodyTransformer

