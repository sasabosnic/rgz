
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
