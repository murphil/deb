FROM nnurphy/qjs:deb-all as q
FROM debian:10.1-slim

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TIMEZONE=Asia/Shanghai

# conf
COPY home /root/

RUN set -ex \
  ; sed -i 's/\(.*\)\(security\|deb\).debian.org\(.*\)main/\1ftp.cn.debian.org\3main contrib non-free/g' /etc/apt/sources.list \
  ; apt-get update \
  ; apt-get upgrade -y \
  ; DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
      dpkg tzdata ca-certificates lsb-release \
      sudo mlocate procps grep sed tree jq bzip2 unzip \
      git zsh bash neovim tmux sqlite3 build-essential \
      inetutils-ping net-tools iproute2 telnet netcat \
      curl wget rsync openssh-client openssh-server \
  ; ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  ; echo "$TIMEZONE" > /etc/timezone \
  ; sed -i 's/^.*\(%sudo.*\)ALL$/\1NOPASSWD:ALL/g' /etc/sudoers \
  ; sed -i 's!.*\(AuthorizedKeysFile\).*!\1 /etc/authorized_keys/%u!' /etc/ssh/sshd_config \
  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

COPY --from=q /usr/local/bin/qjsbn /usr/local/bin/qjs
ENV just_version=0.4.4
ENV watchexec_version=1.10.3
ENV ycat_version=0.2.5
ENV task_version=3.0.0-preview2
ENV websocat_version=1.5.0
ENV wstunnel_version=2.0
ARG just_url=https://github.com/casey/just/releases/download/v${just_version}/just-v${just_version}-x86_64-unknown-linux-musl.tar.gz
ARG watchexec_url=https://github.com/watchexec/watchexec/releases/download/${watchexec_version}/watchexec-${watchexec_version}-x86_64-unknown-linux-musl.tar.gz
ARG ycat_url=https://github.com/alxarch/ycat/releases/download/v${ycat_version}/ycat_${ycat_version}_Linux_x86_64.tar.gz
ARG task_url=https://github.com/go-task/task/releases/download/v${task_version}/task_linux_amd64.tar.gz
ARG websocat_url=https://github.com/vi/websocat/releases/download/v${websocat_version}/websocat_amd64-linux-static+udp
ARG wstunnel_url=https://github.com/erebe/wstunnel/releases/download/${wstunnel_version}/wstunnel_linux_x64
RUN set -ex \
  ; wget -q -O- ${just_url} \
    | tar zxf - -C /usr/local/bin just \
  ; wget -q -O- ${watchexec_url} \
    | tar zxf - --strip-components=1 -C /usr/local/bin watchexec-${watchexec_version}-x86_64-unknown-linux-musl/watchexec \
  ; wget -q -O- ${ycat_url} \
    | tar zxf - -C /usr/local/bin ycat \
  ; wget -q -O- ${task_url} \
    | tar zxf - -C /usr/local/bin task \
  ; wget -q -O /usr/local/bin/websocat ${websocat_url} \
    ; chmod a+x /usr/local/bin/websocat \
  ; wget -q -O /usr/local/bin/wstunnel ${wstunnel_url} \
    ; chmod a+x /usr/local/bin/wstunnel


WORKDIR /root

ENV SSH_USERS=
ENV SSH_ENABLE_ROOT=
ENV SSH_GATEWAY_PORTS=
ENV SSH_OVERRIDE_HOST_KEYS=

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]