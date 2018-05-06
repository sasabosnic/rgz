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

![newsboat](/newsboat.jpeg)
_A list of articles in newsboat_

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

To download and play podcast there is `podboat`:

    $ podboat

![newsboat and podboat](/podboat.jpeg)
_Podcast article in newsboat (top) and the queue in podboat (bottom)_

_Tested on OpenBSD 6.3 with newsboat-2.10.2._
