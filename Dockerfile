FROM nnurphy/qjs:deb-all as q
FROM debian:10-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 TIMEZONE=Asia/Shanghai

COPY home /root/

RUN set -ex \
  ; apt-get update \
  ; apt-get upgrade -y \
  ; DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends ca-certificates lsb-release \
      dpkg tzdata sudo wget iproute2 openssh-client mlocate procps \
      curl bzip2 unzip grep sed git zsh neovim build-essential \
      tree jq \
      inetutils-ping net-tools telnet netcat rsync \
  ; ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  ; echo "$TIMEZONE" > /etc/timezone \
  ; sed -i 's/^.*\(%sudo.*\)ALL$/\1NOPASSWD:ALL/g' /etc/sudoers \
  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

COPY --from=q /usr/local/bin/qjsbn /usr/local/bin/qjs
ENV just_version=0.4.4 watchexec_version=1.10.3
RUN set -ex \
  ; wget -q -O- https://github.com/casey/just/releases/download/v${just_version}/just-v${just_version}-x86_64-unknown-linux-musl.tar.gz \
    | tar zxf - -C /usr/local/bin just \
  ; wget -q -O- https://github.com/watchexec/watchexec/releases/download/${watchexec_version}/watchexec-${watchexec_version}-x86_64-unknown-linux-musl.tar.gz \
    | tar zxf - --strip-components=1 -C /usr/local/bin watchexec-${watchexec_version}-x86_64-unknown-linux-musl/watchexec

# conf
COPY sources.list /etc/apt/sources.list

WORKDIR /root

CMD [ "/bin/zsh" ]