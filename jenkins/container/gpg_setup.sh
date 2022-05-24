# common gpg setup code to be sourced by other scripts in this directory

: ${signing_key:=''}
: ${signer:=''}

export GNUPGHOME="${PWD}/.gnupg"
rm -rf "${GNUPGHOME}"
trap 'rm -rf "${GNUPGHOME}"' EXIT
mkdir --mode=0700 "${GNUPGHOME}"
# Sometimes this directory is not created automatically making further
# private key imports fail, let's create it here as a workaround.
mkdir -p --mode=0700 "${GNUPGHOME}/private-keys-v1.d/"
if [[ -n "${signing_key}" ]]; then
    gpg --import "${signing_key}"
    export SIGNER="${signer}"
fi
