ARG VERSION=latest

FROM ubuntu:${VERSION}

USER root

RUN set -x \
  && echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
  && apt-get update \
  && apt-get update --fix-missing \
  && apt-get install -f -y \
  && apt-get upgrade -y \
  && apt-get install -y \
  apt-utils \
  coreutils \
  sysvinit-utils \
  systemd \
  systemd-sysv \
  software-properties-common \
  build-essential \
  gcc \
  g++ \
  make \
  dialog \
  zip \
  gzip \
  tar \
  unzip \
  acl \
  curl \
  wget \
  nano \
  sudo \
  --no-install-recommends \
  --no-install-suggests \
  ssh \
  && apt-get update \
  && apt-get upgrade -y \
  # Fixing high vulnerability
  && if dpkg -s python3-jwt >/dev/null 2>&1; then apt-get purge --autoremove -y python3-jwt; fi \
  && if dpkg -s python3-urllib3 >/dev/null 2>&1; then apt-get purge --autoremove -y python3-urllib3; fi \
  && if dpkg -s requests >/dev/null 2>&1; then apt-get purge --autoremove -y requests; fi \
  && if dpkg -s certifi >/dev/null 2>&1; then apt-get purge --autoremove -y certifi; fi \
  # Cleaning
  && echo "Y" | dpkg --configure -a \
  && apt-get autoremove -y --purge \
  && apt-get clean -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/* \
  ;

RUN usermod -aG sudo root

# Setting root ssh password
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" "/etc/ssh/sshd_config" \
  && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" "/etc/ssh/sshd_config" \
  ;

RUN echo "root" | cat > ~/.secret \
  && chown root ~/.secret \
  && chmod 0400 ~/.secret \
  ;

COPY ./resources/entrypoint.sh /

RUN chown root /entrypoint.sh \
  && chmod 0700 /entrypoint.sh \
  ;

ENTRYPOINT ["/entrypoint.sh"]

# Keeping container alive
CMD ["/sbin/init", "-D"]
