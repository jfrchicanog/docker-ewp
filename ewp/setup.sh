#!/bin/bash
mkdir -p local-registry/keys/certs_to_trust
mkdir -p local-ewp/ewp-data/keys/certs_to_trust
mkdir -p test-ewp/ewp-data/keys/certs_to_trust
cp local-ewp/ewp-data/keys/local-ewp.pem local-registry/keys/certs_to_trust
cp local-ewp/ewp-data/keys/httpsig.pem local-registry/keys/certs_to_trust
cp test-ewp/ewp-data/keys/httpsig.pem local-registry/keys/certs_to_trust
cp test-ewp/ewp-data/keys/test-ewp.pem local-registry/keys/certs_to_trust

cp test-ewp/ewp-data/keys/test-ewp.pem local-ewp/ewp-data/keys/certs_to_trust
cp local-ewp/ewp-data/keys/local-ewp.pem test-ewp/ewp-data/keys/certs_to_trust

cp local-registry/keys/cert.pem local-ewp/ewp-data/keys/certs_to_trust/registry.pem
cp local-registry/keys/cert.pem test-ewp/ewp-data/keys/certs_to_trust/registry.pem

#cp ../../ewp-reference-connector/ewp-reference-connector/target/ewp-reference-connector-3.0.0-SNAPSHOT.war local-ewp/ewp-data/ewp-reference-connector.war

cd local-registry 
./setup.sh https://local.ewp.uma.es/rest/manifest https://test.ewp.uma.es/ewp/rest/manifest
cd ../local-ewp/ewp-data
./setup.sh
cd ../../test-ewp/ewp-data
./setup.sh
cd ../..
