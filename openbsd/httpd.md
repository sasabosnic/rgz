> "...Thank you @romanzolotarev for the awesome guide on setting this up!"<br>&mdash;
[lamdanerd](https://twitter.com/lambdanerd/status/1028018221729730560 "10 Aug 2018")
(@lambdanerd)

_Tested on [OpenBSD](/openbsd/) 6.3._

# Configure httpd(8) on OpenBSD

[Deploy and login to your server](/vultr.html).

Edit `/etc/httpd.conf`. Add two `server` sections&mdash;one for
`www` and another for naked domain (all requests are redirected to
`www`).

```
server "www.example.com" {
  listen on * port 80
  root "/htdocs/www.example.com"
}

server "example.com" {
  listen on * port 80
  block return 301 "http://www.example.com$REQUEST_URI"
}
```

[httpd(8)](https://man.openbsd.org/httpd.8) is chrooted to `/var/www`
by default, so let's make a document root directory:

<pre>
# <b>mkdir -p /var/www/htdocs/www.example.com</b>
#
</pre>

Save and check the configuration. Enable httpd(8) and start it.

<pre>
# <b>httpd -n</b>
configuration ok
# <b>rcctl enable httpd</b>
# <b>rcctl start httpd</b>
#
</pre>

## Publish your website

Copy your website content into `/var/www/htdocs/www.example.com` and then
test it your web browser.

<pre>
http://XXX.XXX.XXX.XXX/
</pre>

Your web server should be up and running.

## Update DNS records

If there is another HTTPS server using this domain, configure that server
to redirect all HTTPS requests to HTTP.

Now as your new server is ready you can update DNS records accordingly.

```
    example.com. 300 IN     A XXX.XXX.XXX.XXX
www.example.com. 300 IN     A XXX.XXX.XXX.XXX
```

Examine your DNS is propagated.

<pre>
$ <b>dig example.com www.example.com</b>
...
;; ANSWER SECTION:
example.com.         299     IN      A       XXX.XXX.XXX.XXX
...
;; ANSWER SECTION:
www.example.com.     299     IN      A       XXX.XXX.XXX.XXX
...
$
</pre>

Check IP addresses in answer sections.

Open your website in a browser.

```
http://www.example.com/
```

[Enable HTTPS on your server](/openbsd/acme-client.html).
