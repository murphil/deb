FROM debian:buster-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 TIMEZONE=Asia/Shanghai

RUN set -ex \
  ; apt-get update \
  ; apt-get upgrade -y \
  ; DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends ca-certificates \
      dpkg tzdata sudo wget iproute2 openssh-client mlocate procps \
      curl bzip2 unzip grep sed git zsh neovim build-essential \
      tree jq httpie lsb-release \
      inetutils-ping net-tools telnet netcat rsync \
  ; ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  ; echo "$TIMEZONE" > /etc/timezone \
  ; sed -i 's/^.*\(%sudo.*\)ALL$/\1NOPASSWD:ALL/g' /etc/sudoers \
  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# conf
ADD assets.tgz $HOME/

ENV just_version=0.4.4
RUN set -ex \
  ; wget -q -O- https://github.com/casey/just/releases/download/v${just_version}/just-v${just_version}-x86_64-unknown-linux-musl.tar.gz \
    | tar zxf - -C /usr/local/bin just

WORKDIR /root

CMD [ "/bin/zsh" ]