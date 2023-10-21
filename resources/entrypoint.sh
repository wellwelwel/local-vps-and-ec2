#!/bin/bash

chown root ~/.secret
chmod 0400 ~/.secret

PASSWORD=${PASSWORD:-~/.secret}
PORT=${PORT:-22}

if [ -f "$PASSWORD" ]; then
  PASSWORD=$(cat "$PASSWORD")
fi

echo "root:$PASSWORD" | chpasswd
sed -i "s/#Port 22/Port $PORT/" "/etc/ssh/sshd_config"

exec "$@"
