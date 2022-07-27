#!/bin/bash
# Configure EWP
#if [ ! -d "/usr/local/tomee/webapps/4dm1n" ]; then
#	mkdir -p /usr/local/tomee/webapps/4dm1n;
#	cp -r /usr/local/tomee/webapps/ROOT/* /usr/local/tomee/webapps/4dm1n;
#fi
rm -rf /usr/local/tomee/webapps/ROOT/*
unzip /root/ewp-reference-connector.war -d /usr/local/tomee/webapps/ROOT
#unzip /root/test-0.0.1-SNAPSHOT.war -d /usr/local/tomee/webapps/test
mkdir -p /usr/local/tomee/certs
keytool -v -importkeystore -srckeystore /root/keys/ewp-local-uma.p12 -srcstoretype PKCS12 \
	-destkeystore /usr/local/tomee/certs/ewp-local-uma.jks -deststoretype JKS \
	-srcstorepass changeit -deststorepass changeit
 
#keytool -v -importkeystore -srckeystore /root/keys/httpsignature.p12 -srcstoretype PKCS12 \
#	-destkeystore /usr/local/tomee/certs/ewp-local-uma.jks -deststoretype JKS \
#	-srcstorepass changeit -deststorepass changeit

CACERTS_STORE="/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts"
for CERTIFICATE in /root/keys/certs_to_trust/*.pem; do
    echo "Added trusted certificate $CERTIFICATE"
    keytool -import -file "$CERTIFICATE" -keystore $CACERTS_STORE -alias "$CERTIFICATE" -storepass changeit -noprompt
done

cp /root/mysql-connector-java-8.0.21.jar /usr/local/tomee/lib/mysql-connector-java-8.0.21.jar
cp /root/conf/tomee.xml /usr/local/tomee/conf/tomee.xml
cp /root/conf/server.xml /usr/local/tomee/conf/server.xml
cp /root/conf/ewp.properties /usr/local/tomee/conf/ewp.properties
cp /root/conf/catalina.properties /usr/local/tomee/conf/catalina.properties
cp /root/conf/logging.properties /usr/local/tomee/conf/logging.properties
cd /usr/local/tomee
catalina.sh run
