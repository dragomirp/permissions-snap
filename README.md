LXD container instructions:
```
> lxc launch ubuntu:24.04 u1
> lxc file push permissions-snap_0.1_amd64.snap u1/root/permissions-snap_0.1_amd64.snap
> lxc exec u1 bash
> sudo snap install --dangerous --jailmode ./permissions-snap_0.1_amd64.snap
permissions-snap 0.1 installed
# As root
> permissions-snap.cat 
TEST
> permissions-snap.setpriv-cat 
TEST
# Make home for snap_daemon
> mkdir /home/snap_daemon
> chown -R snap_daemon /home/snap_daemon
> usermod -d /home/snap_daemon snap_daemon
# As regular user
> sudo -su ubuntu
> permissions-snap.cat
cat: /var/snap/permissions-snap/x2/test/test_file: Permission denied
> permissions-snap.setpriv-cat 
setpriv: setresuid failed: Operation not permitted
# Escalated to root
> sudo permissions-snap.cat 
TEST
> sudo permissions-snap.setpriv-cat
TEST
# Escalated to snap_daemon
> sudo -u snap_daemon permissions-snap.cat 
TEST
> sudo -u snap_daemon permissions-snap.setpriv-cat 
setpriv: setgroups failed: Operation not permitted
```

LXD VM instructions:
```
> lxc launch --vm ubuntu:24.04 u2
> lxc file push permissions-snap_0.1_amd64.snap u2/root/permissions-snap_0.1_amd64.snap
> lxc exec u2 bash
> sudo snap install --dangerous --jailmode ./permissions-snap_0.1_amd64.snap
2025-07-07T17:18:59Z INFO Waiting for automatic snapd restart...
permissions-snap 0.1 installed
# As root
> export PATH=/snap/bin:$PATH
> permissions-snap.cat
TEST
> permissions-snap.setpriv-cat
TEST
# Make home for snap_daemon
> mkdir /home/snap_daemon
> chown -R snap_daemon /home/snap_daemon
> usermod -d /home/snap_daemon snap_daemon
# As regular user
> sudo -su ubuntu
> permissions-snap.cat
/system.slice/lxd-agent.service is not a snap cgroup
> permissions-snap.setpriv-cat
/system.slice/lxd-agent.service is not a snap cgroup
# Escalated to root
> sudo permissions-snap.cat
TEST
> sudo permissions-snap.setpriv-cat
TEST
# Escalated to snap_daemon
> sudo -u snap_daemon permissions-snap.cat 
/system.slice/lxd-agent.service is not a snap cgroup
> sudo -u snap_daemon permissions-snap.setpriv-cat 
/system.slice/lxd-agent.service is not a snap cgroup 
```
