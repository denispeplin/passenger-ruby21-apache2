#!/bin/sh
/usr/bin/pgrep --pidfile /var/run/apache2/apache2.pid 2>&1 >/dev/null || /usr/sbin/apache2ctl start >>/var/log/apache2.log 2>&1
