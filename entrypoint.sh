#!/usr/bin/sh
cp /root/.ssh-volume/* /root/.ssh
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_ed25519
chmod 644 /root/.ssh/id_ed25519.pub
chmod 644 /root/.ssh/known_hosts
exec "$@"
