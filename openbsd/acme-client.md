> "...thanks for article itself this can help many people to give <a
href="https://mobile.twitter.com/hashtag/OpenBSD">#OpenBSD</a> a chance."<br>
[Ve Telko](https://mobile.twitter.com/vetelko/status/985095582174900224 "14 Apr 2018")
(@vetelko)

---

# Enable HTTPS on OpenBSD with Let's Encrypt and acme-client(1)

I assume you already have [httpd(8)](https://man.openbsd.org/httpd.8)
running on your OpenBSD server. If it's not, [then go ahead and
configure it](/openbsd/httpd.html). I'll wait for you here.

We are going to use [Let's Encrypt](https://letsencrypt.org) as a
certificate authority for Transport Layer Security (TLS) encryption.

Add or update your CAA records to inform Let's Encrypt that they are
allowed to issue certificates for your domain.

        example.com. 300 IN   CAA   0 issue "letsencrypt.org"
    www.example.com. 300 IN   CAA   0 issue "letsencrypt.org"

To manage certificates we need to configure built-in
[acme-client(1)](http://man.openbsd.org/acme-client.1). Add these
three sections to `/etc/acme-client.conf`:

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

<pre>
# <b>mkdir -p -m 700 /etc/acme</b>
# <b>mkdir -p -m 700 /etc/ssl/acme/private</b>
# <b>mkdir -p -m 755 /var/www/acme</b>
</pre>

Update `/etc/httpd.conf` to handle verification requests from Let's
Encrypt.  It should look like this:

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

<pre>
# <b>httpd -n</b>
configuration ok
# <b>rcctl restart httpd</b>
httpd(ok)
httpd(ok)
#
</pre>

Let's run `acme-client` to create new account and domain keys.

<pre>
# <b>acme-client -vAD www.example.com</b>
...
acme-client: /etc/ssl/www.example.com.crt: created
acme-client: /etc/ssl/www.example.com.fullchain.pem: created
</pre>

To renew certificates automatically edit the current crontab:

<pre>
# <b>crontab -e</b>
</pre>

Append this line:

    0 0 * * * acme-client www.example.com && rcctl reload httpd

Save and exit:

<pre>
crontab: installing new crontab
#
</pre>

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

<pre>
 # <b>httpd -n</b>
 configuration ok
 # <b>rcctl restart httpd</b>
 httpd (ok)
 httpd (ok)
 #
</pre>

To verify your setup [run SSL server test](https://www.ssllabs.com/ssltest/analyze.html).

Congratulation! Your website and its visitors are now secured.

## Add domains

Backup and remove the certificate

    mv /etc/ssl/www.example.com.crt /etc/ssl/www.example.com.crt.bak

Add a new alternative name to `/etc/acme-client.conf`:

    ...
    alternative names { example.com new.example.com }
    ...

Add a new server section to  `/etc/httpd.conf`. Use the same certificate and key.

    ...
    server "new.example.com" {
      listen on * tls port 443
      root "/htdocs/new.example.com"
      tls {
        certificate "/etc/ssl/www.example.com.fullchain.pem"
        key "/etc/ssl/private/www.example.com.key"
      }
      location "/.well-known/acme-challenge/*" {
        root { "/acme", strip 2 }
      }
    }
    ...

Request a new certificate with the new alternative new in it. Verify
`httpd.conf` and restart `httpd(8)`:

<pre>
# <b>acme-client -vFAD www.example.com</b>
...
acme-client: /etc/ssl/www.example.com.crt: created
acme-client: /etc/ssl/www.example.com.fullchain.pem: created
# <b>httpd -n</b>
configuration ok
# <b>rcctl restart httpd</b>
httpd(ok)
httpd(ok)
#
</pre>

_Tested on OpenBSD 6.3._

---

**Thanks** to [Tim Chase](https://twitter.com/gumnos),
[Mischa Peters](https://twitter.com/mischapeters),
and [Ve Telko](https://twitter.com/vetelko)
for reading drafts of this,
to [Reyk Floeter](https://reykfloeter.com/)
for [httpd(8)](https://bsd.plumbing)
and to [Kristaps Dzonsons](https://www.divelog.blue/)
for [acme-client(1)](https://kristaps.bsd.lv/acme-client/).
