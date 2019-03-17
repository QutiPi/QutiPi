# CPU Usage

It's helpful sometime to know the total CPU uage, this can be found via the following command:
```bash
grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'
```

However, it can sometime be more helpful to see a dynamic real-time view of the running system. This can be achived via:
```bash
top
```

