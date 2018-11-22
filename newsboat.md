_Tested on [OpenBSD 6.3](/openbsd/) with newsboat-2.10.2_

# Configure newsboat(1) to read RSS feeds in&nbsp;terminal

Install [newsboat(1)](https://www.newsboat.org/). For example, on OpenBSD:

<pre>
# <b>pkg_add newsboat</b>
...
newsboat-2.10.2: ok
#
</pre>

Add the first feed to your `.newsboat/urls`, add `.newsboat/config`, run newsboat(1):

<pre>
$ <b>mkdir -p "$HOME/.newsboat"</b>
$ <b>echo 'https://www.romanzolotarev.com/rss.xml' \</b>
<i><b>"$HOME/.newsboat/urls"</b></i>
$
$ <b>cat &gt; "$HOME/.newsboat/config" &lt;&lt; EOF</b>
<i>browser         "firefox"</i>
<i>player          "mpv"</i>
<i>download-path   "~/downloads/%n"</i>
<i>save-path       "~/downloads"</i>
<i>reload-threads  20</i>
<i>cleanup-on-quit yes</i>
<i>text-width      74</i>
<i></i>
<i>bind-key - quit</i>
<i>bind-key G end</i>
<i>bind-key g home</i>
<i>bind-key j down</i>
<i>bind-key k up</i>
<i><b>EOF</b></i>
$
$ <b>newsboat</b>
</pre>

From a list of feeds select the first one and get the list of items:

<pre>
newsboat 2.10.2 - Articles in feed 'Roman Zolotarev' (1 unread
   1 N  May 06   2.2K  Configure newsboat(1) to read RSS feeds
   2    May 01   1.4K  Configure minimalist login on OpenBSD
   3    May 01   1.8K  Set default applications on X Window Sy
   4    Apr 24   5.3K  My dear sponsor,
   5    Apr 13   5.6K  Enable HTTPS on OpenBSD with Let's Encr
   6    Apr 12   2.4K  Configure OpenBSD httpd(8) on your web
   7    Apr 11   2.4K  Deploy a VPS on Vultr
   8    Apr 07   9.6K  Static site generator with rsync and lo
   9    Apr 03   1.4K  Upgrade OpenBSD
  10    Mar 30   1.6K  Strong password generator
  11    Mar 16   710   Change time zone in OpenBSD
  12    Mar 02   1.6K  Backup with borg
  13    Mar 01   1.8K  Mount drives on OpenBSD
  14    Feb 27   713   Printing from the command line on macOS
  15    Nov 17  12.6K  OpenBSD on my fanless desktop computer
  16    Nov 15   3.8K  Why OpenBSD?
  17    Nov 02   2.1K  Enable full disk encryption on OpenBSD
  18    Oct 10   7.3K  Password manager powered by LibreSSL
  19    Sep 20   2.3K  Install OpenBSD on your desktop
  20    Sep 19   1.0K  Prepare a bootable OpenBSD drive on mac
  21    Sep 01   4.2K  Configure YubiKey for login and SSH on
-:Quit ENTER:Open s:Save r:Reload n:Next Unread A:Mark All Rea
</pre>

Navigate with  `j`, `k`, `G`, `g`, `-`.

Default key bindings:

`Enter` - open the feed or the article<br>
`n` - jump to the next unread article<br>
`p` - jump to the previous unread article<br>
`o` - open an article in your browser<br>
`e` - enqueue podcast for `podboat`<br>
`E` - edit the list of your feeds in `~/.newsboat/urls`<br>
`r` - reload the feed<br>
`q` - go up or quit

Check out my [.newsboat/urls](/blogroll.txt).
