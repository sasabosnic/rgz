_Tested on [OpenBSD](/openbsd/) 6.4_

# Configure nsd(8) on OpenBSD

Install two VMs in two different networks.<br>
For example, [OpenBSD.Amsterdam](oams.html) and [Vultr](vultr.html).

Let's pick arbitrary names for them:

	ns1.example.com
	ns2.example.com

Edit [nsd.conf(5)] on `ns1`,<br>
create a zone file for `example.com`,<br>
copy `nsd.conf` and `example.com.zone` to `ns2`,<br>
enable and start [nsd(8)] on both servers.

<pre>
# <b>cat &gt; /var/nsd/etc/nsd.conf &lt;&lt; EOF</b>
<i>server:</i>
<i>  database: ""</i>
<i></i>
<i>remote-control:</i>
<i>  control-enable: yes</i>
<i>  control-interface: /var/run/nsd.sock</i>
<i></i>
<i>zone:</i>
<i>  name: <em>example.com</em></i>
<i>  zonefile: master/%s.zone</i>
<i>EOF</i>
#
# <b>cat &gt; /var/nsd/zones/master/<em>example.com</em>.zone &lt;&lt; EOF</b>
<i>$ORIGIN             <em>example.com.</em></i>
<i>$TTL    300</i>
<i>@       3600  SOA   <em>ns1.example.com</em>. hostmaster.<em>example.com</em>. (</i>
<i>        2018121401  ; serial YYYYMMDDnn</i>
<i>        1440        ; refresh</i>
<i>        3600        ; retry</i>
<i>        604800      ; expire</i>
<i>        300 )       ; minimum TTL</i>
<i>@             NS    ns1.<em>example.com</em>.</i>
<i>@             NS    ns2.<em>example.com</em>.</i>
<i>ns1           A     <em>46.23.88.178</em></i>
<i>ns2           A     <em>140.82.28.210</em></i>
<i>@             MX    10 smtp.<em>example.com</em>.</i>
<i>@             MX    20 smtp.<em>example.com</em>.</i>
<i>@             A     <em>46.23.88.178</em></i>
<i>www           A     <em>46.23.88.178</em></i>
<i>EOF</i>
#
# <b>rcctl enable nsd</b>
# <b>rcctl start nsd</b>
nsd (ok)
# <b>dig +short <em>example.com</em> NS @127.0.0.1</b>
ns1.example.com.
ns2.example.com.
#
</pre>

Update nameservers `ns1.example.com` and their IP addreses (for
_glue records_) at your domain registrar.  Your mail server should
accept mail for _hostmaster@example.com_.

Verify your setup with [zonemaster.net](https://zonemaster.net).

## Update zone

Edit the zone file and **increment the serial** on `ns1`,<br>
copy the zone file to `ns2`,<br>
restart nsd(8) on `ns1` and `ns2`.

[nsd.conf(5)]: https://man.openbsd.org/nsd.conf.5
[nsd(8)]: https://man.openbsd.org/nsd.8
