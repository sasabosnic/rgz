# Making web faster

As a web developer, you have to focus on a million different things. It is
easy to forget about performance optimization, especially when you are
working against deadlines. This recipe is a good starting point to make
the web faster.

As our computers and internet connection are getting faster, we tend to
care less about performance optimization. How can we fix that? Or do we
need to fix it at all?

Notebooks and desktop computers are [no longer that popular among internet
citizens](http://gs.statcounter.com/platform-market-share/desktop-mobile-tablet).
We live in the era of smartphones. Limited CPU, RAM, and battery. That's
the reality for a billion people today and for the next billion newcomers.

On the other side, the average page grows in size and demands more
powerful devices and faster connections. So the majority of people are
looking at the web through a teeny-tiny window, and **the average page
takes five seconds to load**.

I believe we as web developers are responsible for keeping the internet
nice and tidy. Cat pictures should be accessible to everyone on this
planet!

For a start, you can test your site with something straightforward and
easy to use like [the Pingdom Website Speed
Test](https://tools.pingdom.com).

![Pingdom Speed Test results](/fast-waterfall.png)

If your performance grade is lower than 90, then you should probably fix
it.

## Design lightly

**Set strict constraints.** For a web page like this, I set the following
limits: up to ten requests per page, 1000 ms for render, 1000 ms of load
time. For a single-page application, it can be a few times more.

**Cut everything you can.** Always question yourself before adding every
feature, every asset, every byte. Is it worth adding 300 KB for a web
font? Do I need to place everything on one page? Do I need this huge
background image?

**Simplify layout and typography.** Content is king. Use large fonts and
white space. Avoid huge images and custom web fonts as much as you can.

## Reduce bloat

**Low-res video.** Make sure low bitrate videos are available (e.g., 12
fps, 80 kbps). Make sure your videos looks good at low resolution. Test
all text and every other little detail. Use a larger font for captions.
Keep bitrate low.

**No preload.** Unless it is necessary and expected by users, don't
preload videos and don't start playing automatically.

**Optimize images.** Pick the appropriate format for every image.
Sometimes an indexed PNG at 16 colors beats a JPG, and vice versa. Use
[ImageOptim](https://imageoptim.com) for all images.

**Lazy load.** If your page is long and has lots of images and videos,
lazy-load the page as the viewer scrolls. Use
[bLazy.js](https://github.com/dinbror/blazy/) (it weights 1.4KB) or better
yet, write your own script.

## HTML, CSS, JavaScript

**Minify.** This part is easy. You can minify all text assets at build
time or even let [CloudFlare](https://www.cloudflare.com) do it.

**No frameworks.** Avoid adding CSS and JavaScript frameworks unless you
need them.

**Code-splitting.** Load JavaScript and CSS only when you need them. This
can be challenging without automation, and this kind of optimization
requires a lot of work, but when your app is large you have no choice.

**Keep pages static.** Static HTML is blazingly fast --- use it as much as
possible. For a blog, you can easily avoid databases on the server side
and JavaScript on the client side.

**Third-party scripts.** Think twice about adding social media buttons
(Facebook, Twitter, GitHub, etc.). Use plain text and links instead. The
same applies to *Google Analytics*: get rid of it unless you need all that
data.

Yes, these scripts can be convenient in some cases, but the price is
enormous. Folks with ad blockers won't see the button you want them to
click, while other people will experience a slower page load and
compromised privacy (additional requests, kilobytes of JavaScript, and
cookies).

## Automate

A focus on performance helps you to pick the right tools from the start
and build a great product, but performance optimization becomes
prohibitively expensive as your web app grows.

Talk to your team. Automate web page performance testing. Include it in
your continuous deployment process. Set a performance budget. Catch
performance issues early.

## See also

[Progressive Web Apps with React.js by Addy Osmani](https://medium.com/@addyosmani/progressive-web-apps-with-react-js-part-2-page-load-performance-33b932d97cf2),
[High Performance in the Critical Rendering Path by Nicolas Bevacqua](https://www.youtube.com/watch?v=PqA3jBpT6T0)
