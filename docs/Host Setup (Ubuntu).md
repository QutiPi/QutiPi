# Setup Ubuntu 16.04 for meta-qutipi

To compile meta-qutipi you can use a range of OSs however this guide will cover setting up Ubuntu 16.04 LTS.

Please run the following

```bash
sudo apt install device-tree-compiler build-essential texinfo libncurses5-dev chrpath diffstat gawk python2.7
sudo ln -sf /usr/bin/python2.7 /usr/bin/python
sudo ln -sf /usr/bin/python2.7 /usr/bin/python2
```

Now we will change Ubuntu's shell from the default dash to bash. Run the following and select **no** when prompted.

```bash
sudo dpkg-reconfigure dash
```
