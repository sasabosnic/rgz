_Tested on [macOS](/macos/) 10.13_

# Test site performance with WebPageTest

Install [webpagetest-api](https://github.com/marcelduran/webpagetest-api).

<pre>
$ <b>npm install webpagetest -g</b>
...
$
</pre>

Save your
[specs](https://github.com/marcelduran/webpagetest-api/wiki/Test-Specs)
to [webpagetestspecs.json](/webpagetestspecs.json).

[Request your API key](https://www.webpagetest.org/getkey.php) at
WebPagetest.org. Wait for the email with your key. The API key is limited
to 200 page loads per day.

Export your API key as `WPT_API_KEY` and target URL as `URL`. Run your
test.

<pre>
$ <b>export WPT_API_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</b>
$ <b>export URL=https://www.romanzolotarev.com/</b>
$ <b>webpagetest test $URL --first --poll \
--specs webpagetestspecs.json --key $WPT_API_KEY</b>

WebPageTest
  median.firstView.requests: 6 should be less than 10
  median.firstView.render: 605 should be less than 1000
  median.firstView.loadTime: 527 should be less than 1000
  median.firstView.score_gzip: 100 should be greater than 90

4 passing (6ms)
</pre>

Add this test to your continuous deployment process.
