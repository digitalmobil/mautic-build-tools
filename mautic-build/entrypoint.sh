#!/bin/sh

DATA_UID=$(stat -c "%u" /data)

if [ $DATA_UID -gt 0 ]; then
    echo "Executing as UID $DATA_UID"
    usermod -u $DATA_UID mautic-build >/dev/null 2>&1
    chown -R mautic-build /home/mautic-build
    sudo -u mautic-build "$@"
else
    exec "$@"
fi
