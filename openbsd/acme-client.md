"...thanks for article itself this can help many people to give <a href="https://twitter.com/hashtag/OpenBSD">#OpenBSD</a> a chance."
<div class="quote"><a href="https://mobile.twitter.com/vetelko/status/985095582174900224">
<img src="/avatars/vetelko.jpeg" class="quote__avatar" title="14 Apr 2018" alt="Ve Telko (@vetelko)"></a>
<span class="quote__name">Ve Telko (@vetelko)</span></div>


# Enable HTTPS on OpenBSD with Let's Encrypt and acme-client(1)

I assume you already have [httpd(8)](https://man.openbsd.org/httpd.8)
running on your OpenBSD server. If it's not, [then go ahead and
configure it](/openbsd/webserver.html). I'll wait for you here.

We are going to use [Let's Encrypt](https://letsencrypt.org) as a
certificate authority for Transport Layer Security (TLS) encryption.

Add or update your CAA records to inform Let's Encrypt that they are
allowed to issue certificates for your domain.

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

Congratulation! Your website and its visitors are now secured.

---

**Thanks** to [Tim Chase](https://twitter.com/gumnos),
[Mischa Peters](https://twitter.com/mischapeters), and [Ve
Telko](https://twitter.com/vetelko) for reading drafts of this, to [Reyk
Floeter](https://reykfloeter.com/) for [httpd(8)](https://bsd.plumbing)
and to [Kristaps Dzonsons](https://www.divelog.blue/) for
[acme-client(1)](https://kristaps.bsd.lv/acme-client/).
