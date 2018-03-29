# Device Cheat Sheet

@todo split into smaller files

This guide demonstrates some useful commands and knowledge about controlling your device.

## SSH

You can remotely connect to the device by running the following command, then typing the users password. By default this is 'qutipi'

```shell
ssh root@{ip}
```

The default firewall rules block re-connection within 60 seconds. I.e. If you connect then disconnect, and then try to re-connect within 60 seconds you will receive a connection refused message. You can remove this rules in /etc/firewall.rules files however i highly suggest keeping it in there to defend against attacks.

## Application Control

Qutipi is configured to run an application on boot to shut down this application login via ssh and run the below

```shell
systemctl stop application-loader
```

To start the application back up you run 
```shell
systemctl start application-loader
```

Or you can even restart the application by running
```shell
systemctl restart application-loader
```

## Customise Distro

The way meta-qutipi is design it allows you to expand Qutipi without modifying any of Qutipi's layers. This was dont to promote easy patching and community contribution.

First duplicate the default customise layer

```bash
cp -r customise/qutipi customise/myproject
```

Next enable your new layer by editing build/config 

  * Change CUSTOMISE to myproject

Thats it! You can now add, edit and extend QutiPi while benefiting from continued patches and give back via pull requests

## Changing Default Application

By default Qutipi comes with a default dummy application, you will of course want to change this to your own.

During development you can use Qt Creator to automatically compile your application and remotely deploy and debug it. However once you have a finished program that you want to load on boot every time you have two options.

### Upload Program


### Recompile Qutipi Distro 

Open the receipt "customise/recipes/application/application.bb" 

  * Change "SRC_URI" with the url of your git repo
  * Change "SRCREV" with commit id
  * Add additional Qt packages to DEPENDS that you project may requirer

After that now we build the distro

```bash
cd build
bitbake qt5-image
```

## Network configuration

By default the network configuration is setup via networkd. Depending on the setting during the compilation of Qutipi distro will depend on how networkd is configured.

One method is dhcp and on is static ip, you can check which one you have by running the following command

```shell
ls /etc/systemd/network
```

### DHPC

If you want to switch to DHCP run the following, changing {ETHERNET_MAC} for a mac address 
```shell
rm  /etc/systemd/network/50-static.network
cat <<EOF >/etc/systemd/network/50-dhcp.network
[Match]
Name=eth0

[Link]
MACAddress={ETHERNET_MAC}

[Network]
DHCP=ipv4
EOF
```

### Static

If you want to switch to a static ip, changing everything in curvy bracket with the correct information
```shell
rm  /etc/systemd/network/50-dhcp.network
cat <<EOF >/etc/systemd/network/50-static.network
[Match]
Name=eth0

[Link]
MACAddress=${ETHERNET_MAC}

[Address]
Address=${ETHERNET_IP}/${ETHERNET_NETMASK}
Broadcast=${ETHERNET_BROADCAST}

[Network]
DNS=${ETHERNET_NAMESERVERS}

[Route]
Gateway=${ETHERNET_GATEWAY}

EOF
```
