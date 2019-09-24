FROM nnurphy/qjs:deb-all as q
FROM debian:10.1-slim

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TIMEZONE=Asia/Shanghai

# conf
COPY home /root/

RUN set -ex \
  ; sed -i 's/\(.*\)\(security\|deb\).debian.org\(.*\)main/\1ftp2.cn.debian.org\3main contrib non-free/g' /etc/apt/sources.list \
  ; apt-get update \
  ; apt-get upgrade -y \
  ; DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends ca-certificates lsb-release \
      dpkg tzdata sudo wget iproute2 openssh-client openssh-server mlocate procps \
      curl bzip2 unzip grep sed git zsh neovim build-essential \
      bash tree jq sqlite3 \
      inetutils-ping net-tools telnet netcat rsync \
  ; ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  ; echo "$TIMEZONE" > /etc/timezone \
  ; sed -i 's/^.*\(%sudo.*\)ALL$/\1NOPASSWD:ALL/g' /etc/sudoers \
  ; sed -i 's!.*\(AuthorizedKeysFile\).*!\1 /etc/authorized_keys/%u!' /etc/ssh/sshd_config \
  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

COPY --from=q /usr/local/bin/qjsbn /usr/local/bin/qjs
ENV just_version=0.4.4 watchexec_version=1.10.3
RUN set -ex \
  ; wget -q -O- https://github.com/casey/just/releases/download/v${just_version}/just-v${just_version}-x86_64-unknown-linux-musl.tar.gz \
    | tar zxf - -C /usr/local/bin just \
  ; wget -q -O- https://github.com/watchexec/watchexec/releases/download/${watchexec_version}/watchexec-${watchexec_version}-x86_64-unknown-linux-musl.tar.gz \
    | tar zxf - --strip-components=1 -C /usr/local/bin watchexec-${watchexec_version}-x86_64-unknown-linux-musl/watchexec


WORKDIR /root

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]