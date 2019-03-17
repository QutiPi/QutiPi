# Temperature of CPU

You can obtain the temperature of the CPU through the following command. Tested on RaspberryPi compute module 3:

```bash
cat /sys/class/thermal/thermal_zone0/temp
```

For example:
42932 = 42.932 degrees C
