# Set time zone

Check your current time with [date(1)][date]:

<pre>
# <b>date</b>
Thu Apr  5 12:26:43 UTC 2018
</pre>

As you can see the local timezone is `UTC`. 

Your operating system uses `/etc/localtime` to set time zone information
and that is a symbolic link to `UTC` time zone file. Check it with
[readlink(1)][readlink]:

<pre>
# <b>readlink /etc/localtime</b>
/usr/share/zoneinfo/UTC
</pre>

Find a file for the time zone you want to set with [find(1)][find]:

<pre>
# <b>find /usr/share/zoneinfo -name 'Mos*'</b>
/usr/share/zoneinfo/Europe/Moscow
...
</pre>

The timezone name we are looking for is `Europe/Moscow`.

Set timezone with [zic(8)][zic].

<pre>
# <b>zic -l Europe/Moscow</b>
</pre>

Check if the time zone is set correctly.

<pre>
# <b>readlink /etc/localtime</b>
/usr/share/zoneinfo/Europe/Moscow
# <b>date</b>
Thu Apr  5 15:26:51 MSK 2018
</pre>

---

[date]: https://man.openbsd.org/date.1
[readlink]: https://man.openbsd.org/readlink.1
[find]: https://man.openbsd.org/find.1
[zic]: https://man.openbsd.org/zic.8

_Tested on OpenBSD 6.3_
