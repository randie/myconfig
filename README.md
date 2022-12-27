# myconfig

```
# pre-config
mkdir /tmp/scratch
cd /tmp/scratch

# config
git clone git@github.com:randie/myconfig.git
./myconfig/bin/myconfig.sh

# post-config (optional)
cd
rm -rf /tmp/scratch
```

NOTES:

1. Config files that were replaced are backed up in /tmp/scratch/myconfig-backup-<timestamp>.tar
