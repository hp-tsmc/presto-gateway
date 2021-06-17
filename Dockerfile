FROM maven:3.6.3-openjdk-15 AS builder

COPY . /src/

RUN cd /src && mvn clean install

FROM openjdk:15

COPY --from=builder \
	/src/gateway-ha/target \
	/gateway-ha/target

COPY gateway-ha/gateway-ha-config.yml /gateway-ha-config.yml
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]