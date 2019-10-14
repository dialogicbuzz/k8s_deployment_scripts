#!/bin/sh
#
# Create a Kubernetes Secret for TLS data without using kubectl, 
#
# Usage: create-tls-secret ${NAME} --key ${KEY_FILE} --cert ${CERT_FILE}
#
# The key names used in the secret may be overriden using environment variables.
# CERT_KEY_NAME defines the key name for the cert, default is TLS_CERT
# KEY_KEY_NAME defines the key name for the key, default is TLS_KEY
#

usage() {
  echo "Usage: $(basename $0) NAME --key KEY_FILE --cert CERT_FILE" >&2
}

postional_args=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -c|--cert)
    cert_file="$2"
    shift # skip arg
    shift # skip value
    ;;
    -k|--key)
    key_file="$2"
    shift # skip arg
    shift # skip value
    ;;
    *)    # Save non option args
    postional_args+=("$1") 
    shift # skip arg
    ;;
esac
done
set -- "${postional_args[@]}" # non options args

if [ ! "$1" ]; then
  echo "Missing name" >&2
  usage
  exit 1
fi
name="$1"

if [ ! "$cert_file" ]; then
  echo "Missing cert file name" >&2
  usage
  exit 1
fi
if [ ! -f "$cert_file" ]; then
  echo "Can't find cert file: $cert_file" >&2
  exit 1
fi

if [ ! "$key_file" ]; then
  echo "Missing key file name" >&2
  usage
  exit 1
fi
if [ ! -f "$key_file" ]; then
  echo "Can't find key file: $key_file" >&2
  exit 1
fi

# Read in the files as Base64.
cert_base64=$(cat ${cert_file} | base64 -w0)
key_base64=$(cat ${key_file} | base64 -w0)

# Key names may be overriden by the environment.
: "${CERT_KEY_NAME:=TLS_CERT}"
: "${KEY_KEY_NAME:=TLS_KEY}"

# Generate YAML on standard output.

cat << EOF
apiVersion: v1
kind: Secret
metadata:
  name:  ${name}
type: Opaque
data:
  ${CERT_KEY_NAME}: ${cert_base64}
  ${KEY_KEY_NAME}: ${key_base64}

EOF

