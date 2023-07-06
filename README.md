# myconfig
My Mac configuration files

### Usage
```
# pre-config (optional but recommended, see NOTE #1 below)
mkdir /tmp/scratch
cd /tmp/scratch

# config
git clone git@github.com:randie/myconfig.git
./myconfig/bin/myconfig.sh

# post-config (optional, see NOTE #2 below)
cd
rm -rf /tmp/scratch
```

NOTES:

1. If you don't do the pre-config steps, everything will happen in your current working directory.

2. Files that will be replaced will be backed up in /tmp/scratch/myconfig-backup-*timestamp*.tar. You might want to save this file somewhere else before doing the post-config steps.
