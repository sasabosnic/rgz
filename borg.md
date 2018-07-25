_Tested on [OpenBSD](/openbsd/) 6.3 with borgbackup-1.1.4p0_

# Archive with borg(1)

[Borg](https://www.borgbackup.org/) is a deduplicating archiver
with compression and encryption.

## Install

<pre>
# <b>pkg_add borgbackup</b>
...
borgbackup-1.1.4p0: ok
#
</pre>

## Initialize

<pre>
$ <b>borg init -e repokey -v ~/archives</b>
Initializing repository at "archives"
Enter new passphrase:
Enter same passphrase again:
Do you want your passphrase to be displayed for verification? [yN]:
Remember your passphrase. Your data will be inaccessible without it.
Key in "&lt;Repository /home/romanzolotarev/archives&gt;" created.
Keep this key safe. Your data will be inaccessible without it.
Synchronizing chunks cache...
Archives: 0, w/ cached Idx: 0, w/ outdated Idx: 0, w/o cached Idx: 0.
Done.
$
</pre>

## Back up

<pre>
$ <b>borg create ~/archives::src-20180626-1304 src</b>
Enter passphrase for key /home/romanzolotarev/archives:
$
</pre>

## Restore

<pre>
$ <b>cd /tmp</b>
$ <b>borg extract -v --list ~/archives::src-20180626-1304 src/www/borg.md</b>
Enter passphrase for key /home/romanzolotarev/archives:
src/www/borg.md
$ <b>sha256 /tmp/src/www/borg.md ~/src/www/borg.md</b>
SHA256 (/tmp/src/www/borg.md) = 66d23...
SHA256 (/home/romanzolotarev/src/www/borg.md) = 66d23...
$
</pre>

## Set up a remote storage

To keep archives off-site [set up your own server](/openbsd/) or
[sign up for Rsync.net](https://www.rsync.net/products/attic.html)
($10/year for 40 GB or $0.24/year/GB).

## Automate

Create `~/bin/borgbackup` script like this:

<pre>
#!/bin/sh
export BORG_REPO='<b>USERNAME@SERVER.rsync.net:REPO</b>'
export BORG_RSH="ssh -i <b>$HOME/.ssh/PUBLIC_KEY</b>"
export BORG_REMOTE_PATH='/usr/local/bin/borg1/borg1'
export BORG_PASSPHRASE='<b>PASSPHRASE</b>'

archive=$(date +%Y%m%d-%H%M)
borg create -C lzma,9 -p \
	--exclude <b>'*/.cache/*'</b> \
	--exclude <b>'*/Downloads/*'</b> \
	"::$archive" <b>"$HOME"</b>

borg prune -v --list --stats \
	--keep-hourly 48 \
	--keep-daily 60 \
	--keep-monthly 12 \
	--keep-yearly 10 \
	'::'
</pre>

<pre>
$ <b>chmod 0700 ~/bin/borgbackup</b>
$ <b>~/bin/borgbackup</b>
...
------------------------------------------------------------------------------
Keeping archive: 20180726-1352                        Thu, 2018-07-26 13:05:15
...
Keeping archive: 20180331-1505                        Sat, 2018-03-31 12:05:37
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
Deleted data:                    0 B                  0 B                  0 B
All archives:               66.93 GB             66.65 GB              7.38 GB

                       Unique chunks         Total chunks
Chunk index:                   34152               185692
------------------------------------------------------------------------------
Remote: Starting repository check
Remote: Starting repository index check
Remote: Completed repository check, no problems found.
Starting archive consistency check...
Analyzing archive 20180331-1505 (1/10)
...
Analyzing archive 20180726-1305 (10/10)
Archive consistency check complete, no problems found.
$
</pre>

Use [crontab(1)](https://man.openbsd.org/crontab.1) to run
`~/bin/borgbackup` by schedule.
