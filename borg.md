# Backup with borg

Install [BorgBackup](https://www.borgbackup.org/):

    # pkg_add borgbackup

Initialize the repository:

    $ borg init -v '~/backups'

Create the first archive:

    $ borg create --list -p -s -v "~/backups::$(date +%Y%m%d-%H%M)"

To automate your backups let's create a little shell script:

    #!/bin/sh
    export BORG_REPO='USERNAME@SERVER.rsync.net:REPO'
    export BORG_REMOTE_PATH='/usr/local/bin/borg1/borg1'
    export BORG_RSH="ssh -i $HOME/.ssh/key"
    export BORG_PASSPHRASE='hoinaset'
    archive=$(date +%Y%m%d-%H%M)
    borg create -C lzma,9 -p -s "::$archive" "$HOME"

    borg prune -v --list --stats\
      --keep-hourly 48\
      --keep-daily 60\
      --keep-monthly 12\
      --keep-yearly 10\
      '::'

To check repository:

    $ borg check -v '::'

To extract

    $ borg extract -v --list '::' home/romanzolotarev/.vim/vimrc

## Removable storage

    # mkdir -p "/mnt/$drive"
    # mount "/dev/$drive" "/mnt/$drive"
    # umount "/dev/$drive"

## Remote storage

You can setup your own server or use something like
[Rsync.net](http://www.rsync.net/products/attic.html) account ($9/year for
25 GB or $0.36/year/GB).

---

Tested on OpenBSD 6.3 with borgbackup-1.1.4p0.
