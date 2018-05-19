# Configure newsboat(1) to read RSS feeds in&nbsp;terminal

Install [newsboat(1)](https://www.newsboat.org/). For example, on OpenBSD:

    # pkg_add newsboat
    quirks-2.414 signed on 2018-03-28T14:24:37Z
    newsboat-2.10.2: ok
    #

Add the first feed to your `.newsboat/urls`:

    $ mkdir -p "$HOME/.newsboat"
    $ echo 'https://www.romanzolotarev.com/rss.xml' \
    > "$HOME/.newsboat/urls"
    $

By the way, check out [my list of feeds](/blogroll.txt).

Optionally add `.newsboat/config`:

    browser         "firefox"
    player          "mpv"
    download-path   "~/downloads/%n"
    save-path       "~/downloads"
    reload-threads  20
    cleanup-on-quit yes
    text-width      74

    bind-key - quit
    bind-key G end
    bind-key g home
    bind-key j down
    bind-key k up

Run `newsboat`:

    $ newsboat

You'll get a list of feeds, select the first one and get the list of items:

    newsboat 2.10.2 - Articles in feed 'Roman Zolotarev' (1 unread, 21 total) - http
       1 N  May 06   2.2K  Configure newsboat(1) to read RSS feeds interminal
       2    May 01   1.4K  Configure minimalist login on OpenBSD
       3    May 01   1.8K  Set default applications on X Window System
       4    Apr 24   5.3K  My dear sponsor,
       5    Apr 13   5.6K  Enable HTTPS on OpenBSD with Let’s Encrypt and acme-clien
       6    Apr 12   2.4K  Configure OpenBSD httpd(8) on your web server
       7    Apr 11   2.4K  Deploy a VPS on Vultr
       8    Apr 07   9.6K  Static site generator with rsync and lowdown
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
      20    Sep 19   1.0K  Prepare a bootable OpenBSD drive on macOS
      21    Sep 01   4.2K  Configure YubiKey for login and SSH on OpenBSD
    -:Quit ENTER:Open s:Save r:Reload n:Next Unread A:Mark All Read /:Search ?:Help


As you can see in my configuration, I bind `j`, `k`, `G`, `g`, `-`
keys to navigate feeds and articles.

There are useful default key bindings, though:

- `Enter` - open the feed or the article
- `n` - jump to the next unread article
- `p` - jump to the previous unread article
- `o` - open an article in your browser
- `e` - enqueue podcast for `podboat`
- `E` - edit the list of your feeds in `~/.newsboat/urls`
- `r` - reload the feed
- `q` - go up or quit

---
Tested on OpenBSD 6.3 with newsboat-2.10.2.
