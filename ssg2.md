<pre>
&#9484;&#9472;&#9488;&#9484;&#9472;&#9488;&#9484;&#9472;&#9488;
&#9492;&#9472;&#9488;&#9492;&#9472;&#9488;&#9474; &#9516;
&#9492;&#9472;&#9496;&#9492;&#9472;&#9496;&#9492;&#9472;&#9496;
</pre>

# Static Site Generator 2

## Changes

ssg1                                     | ssg2
:--                                      | :--
102 pp (31,306 words) 2,080 ms           |
env vars and `_ssg.conf`                 | removed RSS related props
`rss.xml` based on index.html            | `*.xml` based on `_*.conf`
`ssg build`                              | `ssg`
`ssg build --clean`                      | _removed_
`ssg watch --clean`                      | _removed_
`ssg watch`                              | _removed_
dependencies: `rsync`, `lowdown`, `entr` | `lowdown`

The previous version: [ssg1](ssg1.html)

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

	$ cat news/feed.conf # few arbitrarily selected pages
	title="News"
	description="New how-to guides and shell scripts"
	author="hi@romanzolotarev.com (Roman Zolotarev)"
	root="https://www.romanzolotarev.com"

	2018-11-21 news/page29.html
	...
	2018-10-15 news/page11.html
	2018-10-01 news/page10.md
	$
	$ cat news/page10.html # a page without header and footer
	<h1>Title 10</h1>
	...
	$
	$ rssg news/feed.conf news/feed.rss
