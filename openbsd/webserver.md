# Run OpenBSD on your web server

Before we start, let me list all the steps:

1. Deploy a new server
1. Configure and start an HTTP daemon
1. Publish your website
1. Update DNS records
1. Issue a TLS certificate
1. Enable HTTPS and restart the daemon

Let's begin.

## Deploy a new server

If you need a new server, make sure you have your [public SSH
key](/ssh.html) handy, then register at
[Vultr](https://www.vultr.com/?ref=7035749 "Disclaimer: It's a referal
link") and deploy your server.

For example:

1. Server Location: **Miami**
1. Server Type: 64 bit OS, **OpenBSD 6 x64**
1. Server Size: 20 GB SSD **$2.50/mo** 1 CPU 512MB Memory 500GB Bandwidth
1. Additional Features: None
1. Start Script: None
1. SSH Keys: Add new key
1. Firewall Group: No firewall
1. Server Hostname & Label: **www**

In a minute your sever will be deployed. Login using the new IP address
and your private SSH key (assuming it's in the default location: `~/.ssh/id_ed25519`):

    $ ssh root@XXX.XXX.XXX.XXX
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

Yes, `root` login is enabled on Vultr servers by default. We better harden
a server right after its first boot, but this topic deserves its own post.

## Configure and start an HTTP daemon

OpenBSD comes with [httpd(8)](http://man.openbsd.org/httpd.8)---an HTTP
server with TLS support. Let's edit its configuration:

    www# vi /etc/httpd.conf

Add two `server` sections---one for `www` and another for naked domain (all requests are
redirected to `www`).

    server "www.example.com" {
      listen on * port 80
      root "/htdocs/www.example.com"
    }

    server "example.com" {
      listen on * port 80
      block return 301 "http://www.example.com$REQUEST_URI"
    }

`httpd` is chrooted to `/var/www` by default, so let's make a document
root directory:

    www# mkdir -p /var/www/htdocs/www.example.com

Save and check this configuration:

    www# httpd -n
    configuration ok

Enable `httpd(8)` daemon and start it.

    www# rcctl enable httpd
    www# rcctl start httpd

## Publish your website

Copy your website content into `/var/www/htdocs/www.example.com` and then
test it your web browser.

    http://XXX.XXX.XXX.XXX/

Your web server should be up and running.

## Update DNS records

If there is another HTTPS server using this domain, configure that server
to redirect all HTTPS requests to HTTP.

Now as your new server is ready you can update DNS records accordingly.

        example.com. 300 IN     A XXX.XXX.XXX.XXX
    www.example.com. 300 IN     A XXX.XXX.XXX.XXX

Examine your DNS is propagated.

    $ dig example.com www.example.com

Check IP addresses it answer sections. If they are correct, you should be
able to access your new web server by its domain name.

    http://www.example.com/

## Issue a TLS certificate

We are going to use [Let's Encrypt](https://letsencrypt.org) as a
certificate authority for Transport Layer Security (TLS) encryption.

Optional: Add or update your CAA records to inform Let's
Encrypt that they are allowed to issue
certificates for your domain.

        example.com. 300 IN   CAA 0 issue letsencrypt.org
    www.example.com. 300 IN   CAA 0 issue letsencrypt.org

To manage certificates we need to configure built-in
[acme-client(1)](http://man.openbsd.org/acme-client.1):

    www# vi /etc/acme-client.conf

Add these three sections:

    authority letsencrypt {
      api url "https://acme-v01.api.letsencrypt.org/directory"
      account key "/etc/acme/letsencrypt-privkey.pem"
    }
    authority letsencrypt-staging {
      api url "https://acme-staging.api.letsencrypt.org/directory"
      account key "/etc/acme/letsencrypt-staging-privkey.pem"
    }
    domain www.example.com {
      alternative names { example.com }
      domain key "/etc/ssl/private/www.example.com.key"
      domain certificate "/etc/ssl/www.example.com.crt"
      domain full chain certificate "/etc/ssl/www.example.com.fullchain.pem"
      sign with letsencrypt
    }

Create directories:

    www# mkdir -p -m 700 /etc/acme
    www# mkdir -p -m 700 /etc/ssl/acme/private
    www# mkdir -p -m 755 /var/www/acme

Update `/etc/httpd.conf` to handle verification requests from Let's Encrypt.
It should look like this:

    server "www.example.com" {
      listen on * port 80
      root "/htdocs/www.example.com"
      location "/.well-known/acme-challenge/*" {
        root { "/acme", strip 2 }
      }
    }

    server "example.com" {
      listen on * port 80
      block return 301 "http://www.example.com$REQUEST_URI"
    }

Check this configuration and restart `httpd`:

    www# httpd -n
    configuration ok
    www# rcctl restart httpd
    httpd(ok)
    httpd(ok)
    www#

Let's run `acme-client` to create new account and domain keys.

    www# acme-client -vAD www.example.com
    ...
    acme-client: http://cert.int-x3.letsencrypt.org/: full chain
    acme-client: cert.int-x3.letsencrypt.org: DNS: 104.73.25.126
    acme-client: /etc/ssl/www.example.com.crt: created
    acme-client: /etc/ssl/www.example.com.fullchain.pem: created

To renew certificates automatically edit the current crontab:

    www# crontab -e

Append this line:

    0 0 * * * acme-client www.example.com && rcctl reload httpd

Save and exit:

    crontab: installing new crontab
    www#

## Enable HTTPS and restart the daemon

Now we have the new certificate and domain key, so we can re-configure
`httpd` to handle HTTPS requests. Add two server sections to
`/etc/httpd.conf` for TLS. The result should look like this:

    server "www.example.com" {
      listen on * tls port 443
      root "/htdocs/www.example.com"
      tls {
        certificate "/etc/ssl/www.example.com.fullchain.pem"
        key "/etc/ssl/private/www.example.com.key"
      }
      location "/.well-known/acme-challenge/*" {
        root { "/acme", strip 2 }
      }
    }

    server "example.com" {
      listen on * tls port 443
      tls {
        certificate "/etc/ssl/www.example.com.fullchain.pem"
        key "/etc/ssl/private/www.example.com.key"
      }
      location "/.well-known/acme-challenge/*" {
        root { "/acme", strip 2 }
      }
      location * {
        block return 301 "https://www.example.com$REQUEST_URI"
      }
    }

    server "www.example.com" {
      listen on * port 80
      alias "example.com"
      block return 301 "https://www.example.com$REQUEST_URI"
    }

Test this configuration and restart `httpd`:

    www# httpd -n
    configuration ok
    www# rcctl restart httpd
    www#

To verify your setup [run SSL server test](https://www.ssllabs.com/ssltest/analyze.html).

Congratulation! You're running OpenBSD on your web server.

---

**Thanks** to [Tim Chase](https://twitter.com/gumnos),
[Mischa Peters](https://twitter.com/mischapeters), and [Ve
Telko](https://twitter.com/vetelko) for reading drafts of this, to [Reyk
Floeter](https://reykfloeter.com/) for [httpd(8)](https://bsd.plumbing)
and to [Kristaps Dzonsons](https://www.divelog.blue/) for
[acme-client(1)](https://kristaps.bsd.lv/acme-client/).
