function gen-wg-key {
    umask 077 # default: 022
    wg genkey | tee ${1:-wg} | wg pubkey > ${1:-wg}.pub
}
