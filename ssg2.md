Thinking about API:

$ cat page1.md # md pages converted to html
# Title 1
...
$ cat page1.html # html
<h1>Title 1</h1>
...
$ cat path/to/page2.html # html pages stay as is
<h1>Title 2</h1>
...
$ cat path/to/page2.html # html pages stay as is
<h1>Title 2</h1>
...

$ cat news/feed.txt # few arbitrarily selected pages
2018-11-21 news/page29.html
...
2018-10-15 news/page11.html
2018-10-01 news/page10.md
$
$ cat news/page10.html # a page without header and footer
<h1>Title 10</h1>
...
$
$ rssg news/feed.txt news/feed.rss
