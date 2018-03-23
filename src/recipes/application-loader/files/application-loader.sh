#!/bin/sh

case "$1" in
start)
    if [ -x /home/root/qutipi/program ]; then
        /home/root/qutipi/src &
        echo $!>/var/run/qutipi.pid
    fi
    ;;
restart)
    kill `cat /var/run/qutipi.pid`
    rm /var/run/hit.pid

    /home/root/qutipi/src &
    echo $!>/var/run/qutipi.pid
    ;;
*)
stop)
    kill `cat /var/run/qutipi.pid`
    rm /var/run/hit.pid
    ;;
*)
    echo "Usage: $0 {start|stop}"
    exit 1
esac
exit 0
