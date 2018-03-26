# Basic Systemd Info

Systemd provides the base building blocks for a linux distrobution which boostraps the user space and manages system process. I suggest reading up on how systemd works if you want to make system changes to Qutipi distro.

Systemd is used as the default init system for QutiPi distro, however SysVInit should work as recipes to create init scripts but is not tested.

## Updating Service File

Systemd uses system files to determin how services are configured. These are located at /lib/systemd/system

You can modify any of these services, for example:

```bash
nano /lib/systemd/system/application-loader.service
```

Afterward i suggest running

```bash
systemctl daemon-reload 
systemctl restart application-loader
```

## View Service's Status

See the status of running services by running the below

```bash
systemctl status
```

# See all systemd logs

Viewing logs for systemd event can be helpful to debug problems, for example to view all logs run

```bash
journalctl
```

Or we can tail the logs

```bash
journalctl -f
```

Or just show logs for one service

```bash
journalctl -u application-loader.service
```

