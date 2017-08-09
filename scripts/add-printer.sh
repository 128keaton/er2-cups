#!/usr/bin/bash

script=/opt/cups/install-printers.sh

# Need monitor mode to use fg
set -o monitor

# Run cupsd as the user wanted
/usr/sbin/cupsd "$@" &

# Install printers if supplied
if [ -f $script ]; then
    while [ "$(lpinfo -m 2>/dev/null || echo fail)" == "fail" ]; do
        echo Waiting for cupsd to start... >> /dev/stderr
        sleep 1
    done

    echo Installing printers... >> /dev/stderr
    chmod a+x $script
    $script

    echo Removing $script... >> /dev/stderr
    rm $script
fi

# Now get cupsd to the foreground if it is still running
if [ "$(jobs -r)" != "" ]; then
    fg
fi
