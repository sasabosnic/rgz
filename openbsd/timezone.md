# Change time zone in OpenBSD

Link one of time zone files to `/etc/localtime`. For example, to&nbsp;`Asia/Singapore`:

    # ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
    # date
    Thu Apr  5 20:26:40 +08 2018

or simply use [zic(8)](https://man.openbsd.org/zic.8) (in this example to&nbsp;`Europe/Moscow`):

    # zic -l Europe/Moscow
    # date
    Thu Apr  5 15:26:51 MSK 2018

_Tested on OpenBSD 6.3._

## See also

[ln(1)](https://man.openbsd.org/ln),
[date(1)](https://man.openbsd.org/date)
