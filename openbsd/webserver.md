# Configure OpenBSD httpd(8) on your web server

[Deploy and login to your OpenBSD server first](/vultr.html).

As soon as you're there you can enable an
[httpd(8)](http://man.openbsd.org/httpd.8) daemon, it's already installed
on OpenBSD, you just need to configure it:

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

What's next? [Enable HTTPS on your server](/openbsd/acme-client.html).
