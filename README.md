# myconfig
My Mac configuration files

### Usage
```
# pre-config (optional but recommended)
mkdir /tmp/scratch
cd /tmp/scratch

# config
git clone git@github.com:randie/myconfig.git
./myconfig/bin/myconfig.sh

# post-config (optional, see NOTE #1 below)
cd
rm -rf /tmp/scratch
```

NOTES:

1. Config files that were replaced are backed up in /tmp/scratch/myconfig-backup-*timestamp*.tar. You might want to save this file somewhere else before deleting /tmp/scratch/.
