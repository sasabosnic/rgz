_Tested on [OpenBSD](/openbsd/) 6.3_

# Set time zone on OpenBSD

Check your current time with [date(1)][date]:

<pre>
# <b>date</b>
Thu Apr  5 12:26:43 UTC 2018
#
</pre>

The local timezone is _UTC_.

Check `/etc/localtime` with [readlink(1)][readlink]:

<pre>
# <b>readlink /etc/localtime</b>
/usr/share/zoneinfo/UTC
#
</pre>

It's a symbolic link to _UTC_ time zone file.

Find a file for the time zone you want to set with [find(1)][find]:

<pre>
# <b>find /usr/share/zoneinfo -name 'Mos*'</b>
/usr/share/zoneinfo/Europe/Moscow
...
#
</pre>

Set timezone with [zic(8)][zic].

<pre>
# <b>zic -l Europe/Moscow</b>
#
</pre>

Check the time zone:

<pre>
# <b>readlink /etc/localtime</b>
/usr/share/zoneinfo/Europe/Moscow
# <b>date</b>
Thu Apr  5 15:26:51 MSK 2018
#
</pre>

[date]: https://man.openbsd.org/date.1
[readlink]: https://man.openbsd.org/readlink.1
[find]: https://man.openbsd.org/find.1
[zic]: https://man.openbsd.org/zic.8
