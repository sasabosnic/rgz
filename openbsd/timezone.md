# Change time zone in OpenBSD

Link one of time zone file to `/etc/localtime`. For example, for Singapore:

    # ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
    # date
    Thu Apr  5 20:26:40 +08 2018

or simply:

    # zic -l Europe/Moscow
    # date
    Thu Apr  5 15:26:51 MSK 2018

## See also

[zic(8)](https://man.openbsd.org/zic),
[ln(1)](https://man.openbsd.org/ln),
[date(1)](https://man.openbsd.org/date).
