# Run OpenBSD on your web server

Before you start, make sure you have [SSH key pair](/ssh.html)
generated. If you need a new server, register at
[Vultr](https://www.vultr.com/?ref=7035749 "Disclaimer: It's a referal
link") and deploy your server in few minutes. For example:

1. Server Location: **Miami**
1. Server Type: 64 bit OS, **OpenBSD 6 x64**
1. Server Size: 20 GB SSD **$2.50/mo** 1 CPU 512MB Memory 500GB Bandwidth
1. Additional Features: Enable IPv6
1. Start Script: None
1. SSH Keys: Add new key and then select it
1. Firewall Group: No firewall
1. Server Hostname & Label: **www**

After few minutes your sever will be deployed with a new IP address.
Update your DNS zone accordingly.

    www.example.com. 300 IN   CAA 0 issue letsencrypt.org
        example.com. 300 IN   CAA 0 issue letsencrypt.org
        example.com. 300 IN     A 93.184.216.34
    www.example.com. 300 IN CNAME example.com.

Assuming your private SSH key is in `~/.ssh/` you can login to the server,
like this:

    $ ssh root@example.com
    OpenBSD 6.3 (GENERIC.MP) #107: Sat Mar 24 14:21:59 MDT 2018

    Welcome to OpenBSD: The proactively secure Unix-like operating
    system.

    Please use the sendbug(1) utility to report bugs in the system.
    Before reporting a bug, please try to reproduce it with the
    latest version of the code. With bug reports, please try to
    ensure that enough information to reproduce the problem is
    enclosed, and if a known fix for it exists, include that as
    well.

    www#

Hooray!

First, patch the system:

    www# echo 'http://cloudflare.cdn.openbsd.org/pub/OpenBSD' \
    > /etc/installurl
    www# syspatch

## Configure `httpd(8)` with `acme-client(1)`

Let's configure [httpd(8)](http://man.openbsd.org/httpd.8).

    www# vi /etc/httpd.conf

Edit your `/etc/httpd.conf`

    server "example.com" {
      listen on * port 80
      listen on :: port 80
      root "/htdocs/example.com"
      location "/.well-known/acme-challenge/*" {
        root "/acme"
        root strip 2
      }
    }

Make directories for httpd(8):

    www# mkdir -p /var/www/htdocs/example.com
    www# mkdir -p /var/www/logs/example.com
    www# echo 'Hello world' > \
    /var/www/htdocs/example.com/index.html

And for acme-client(1):

    www# mkdir -p -m 700 /etc/acme
    www# mkdir -p -m 700 /etc/ssl/acme/private
    www# mkdir -p /var/www/acme
    www# vi /etc/acme-client.conf

Replace with your domain name:

    authority letsencrypt {
      api url "https://acme-v01.api.letsencrypt.org/directory"
      account key "/etc/acme/letsencrypt-privkey.pem"
    }
    authority letsencrypt-staging {
      api url "https://acme-staging.api.letsencrypt.org/directory"
      account key "/etc/acme/letsencrypt-staging-privkey.pem"
    }
    domain example.com {
      alternative names { www.example.com }
      domain key "/etc/ssl/private/example.com.key"
      domain certificate "/etc/ssl/example.com.crt"
      domain full chain certificate "/etc/ssl/example.com.fullchain.pem"
      sign with letsencrypt
    }

Start httpd(8):

    www# rcctl enable httpd
    www# rcctl start httpd
    httpd(ok)
    www#

Open your website in a browser to test.

Initialize a new account and domain key:

    www# acme-client -vAD example.com

To renew the certificate add this job to crontab

    0 0 * * * acme-client example.com && rcctl reload httpd

## Enable HTTPS

Edit `/etc/httpd.conf` again:

    server "example.com" {
      listen on * port 80
      listen on :: port 80
      root "/htdocs/example.com"
      location "/.well-known/acme-challenge/*" {
        root "/acme"
        root strip 2
      }
      location * {
        block return 302 "https://$HTTP_HOST$REQUEST_URI"
      }
    }
    server "example.com" {
      listen on * tls port 443
      listen on :: tls port 443
      root "/htdocs/example.com"
      tls {
        certificate "/etc/ssl/example.com.fullchain.pem"
        key "/etc/ssl/private/example.com.key"
      }
      location "/.well-known/acme-challenge/*" {
        root "/acme"
        root strip 2
      }
    }

Restart `httpd`:

    www# rcctl restart httpd

Done!

---

**Thanks** to [Tim Chase](https://twitter.com/gumnos) and [Ve
Telko](https://twitter.com/vetelko) for reading drafts of this, to [Reyk
Floeter](https://reykfloeter.com/) for [httpd(8)](https://bsd.plumbing)
and to [Kristaps Dzonsons](https://www.divelog.blue/) for
[acme-client(1)](https://kristaps.bsd.lv/acme-client/).
