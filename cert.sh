export CERT_FILE=cert.file
export KEY_FILE=cert.key
export HOST=jitsi.otcdemo.gardener.t-systems.net
export CERT_NAME=jitsi-meet-web

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${KEY_FILE} -out ${CERT_FILE} -subj "/CN=${HOST}/O=${HOST}"

kubectl -n jitsi create secret tls ${CERT_NAME} --key ${KEY_FILE} --cert ${CERT_FILE}
