#!/bin/bash

exec "$SNAP/usr/bin/setpriv" --clear-groups --reuid snap_daemon --regid snap_daemon -- cat "$SNAP_DATA/test/test_file"
