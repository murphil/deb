function gen-wg-key {
    umask 077 # default: 022
    wg genkey | tee ${1:-wg} | wg pubkey > ${1:-wg}.pub
}

function re-zsh {
    source ~/.zshrc
}

function make-swapfile {
    local sf=${2:-\/root\/swapfile}
    dd if=/dev/zero of=$sf bs=1M count=$((1024*${1:-16})) # GB
    chmod 0600 $sf
    mkswap $sf
    swapon $sf
    echo "$sf swap swap defaults 0 2" >> /etc/fstab
}

alias ssc='systemctl'

function gen-ecc-key {
    local key=${1:-'key'}
    local pub=${2:-'pub'}
    openssl ecparam -genkey -name secp521r1 -out $key.pem
    chmod 600 $key.pem
    openssl ec -in $key.pem -pubout -out $key.$pub.pem
    ssh-keygen -y -f $key.pem > $key.pub
    #ssh-copy-id -f -i ./id_ecdsa.pub $remote
}

alias ssh-copy-id-with-pwd='ssh-copy-id -o PreferredAuthentications=password -o PubkeyAuthentication=no -f -i'

function iptables---- {
    iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    iptables -A INPUT -p tcp -m multiport --dport 22,80,443 -j ACCEPT
    iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    iptables -A INPUT -p tcp --dport 55555 -j ACCEPT
    iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A INPUT -i wg0 -j ACCEPT
    iptables -P INPUT DROP
}

function iptables-allow-address {
    iptables -A INPUT -s $1 -j ACCEPT
}

function iptables-clean-input {
    iptables -P INPUT ACCEPT
    iptables -F
}

alias iptables-list-input="iptables -L INPUT --line-num -n"
