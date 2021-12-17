sed -i 's/dbms.connector.https.enabled=false/dbms.connector.https.enabled=true/g' /etc/neo4j/neo4j.conf
sed -i 's/#dbms.connector.bolt.tls_level=DISABLED/dbms.connector.bolt.tls_level=OPTIONAL/g' /etc/neo4j/neo4j.conf
sed -i 's/#dbms.ssl.policy/dbms.ssl.policy/g' /etc/neo4j/neo4j.conf

/etc/pki/tls/certs/make-dummy-cert cert
awk '/-----BEGIN PRIVATE KEY-----/,/-----END PRIVATE KEY-----/' cert > private.key
awk '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/' cert > public.crt

for service in bolt https cluster backup; do
  mkdir -p /var/lib/neo4j/certificates/${service}/trusted
  mkdir -p /var/lib/neo4j/certificates/${service}/revoked
  cp private.key /var/lib/neo4j/certificates/${service}
  cp public.crt /var/lib/neo4j/certificates/${service}
done

chown -R neo4j:neo4j /var/lib/neo4j/certificates
chmod -R 444 /var/lib/neo4j/certificates
