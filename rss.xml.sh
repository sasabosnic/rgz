#!/bin/sh
set -e


main () {
	base="$(dirname "$(readlink -f "$0")")"
	(cat <<-EOF
	2018-09-17 2018-09-17.html
	2018-08-26 2018-08-26.html
	EOF
	) | render_items "$base" | render_feed
}


render_items() {
	while read -r item
	do render_item "$1" "$item"
	done
}


render_item() {
	base="$1"
	item="$2"
	root="https://www.romanzolotarev.com"
	# date=$(echo "$item"|awk '{print$1}')
	file=$(echo "$item"|awk '{print$2}')
	url="/$file"
	description=$(rel_to_abs_urls "$root" < "$base/$file" | format_text)
	title=$(echo "$description" | grep '^<h1' | head -1 | sed 's/<[^>]*>//g')

	cat <<-EOF

	<item>
	<guid>$root$url</guid>
	<link>$root$url</link>
	<pubDate>20 Sep 2018 00:00:00 +0000</pubDate>
	<title>$title</title>
	<description><![CDATA[

	$description

	]]></description>
	</item>
	EOF
}


format_text() {
	sed 's/\&nbsp;/ /g' | fmt
}


rel_to_abs_urls() {
	href='s#href="/#href="'"$1"'/#g'
	src='s#src="/#src="'"$1"'/#g'
	sed "$href;$src"
}


render_feed() {
	title='Mastering the Web'
	description='Self-hosted websites. Shell scripts and text editors. How-to guides for BSD/Unix users. Tutorials for web developers.'
	root='https://www.romanzolotarev.com'
	author='hi@romanzolotarev.com (Roman Zolotarev)'
	rss_url="$root/rss.xml"
	date_rfc_822=$(stat -f%Sm -t "%a, %d %b %Y %H:%M:%S %z" "$0")

	cat <<-EOF
	<?xml version="1.0" encoding="UTF-8"?>
	<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
	<atom:link href="$rss_url" rel="self" type="application/rss+xml" />
	<title>$title</title>
	<description>$description</description>
	<link>$root/</link>
	<lastBuildDate>$date_rfc_822</lastBuildDate>
	<managingEditor>$author</managingEditor>
	$(cat)
	</channel></rss>
	EOF
}

main "$@"
