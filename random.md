_Tested on [OpenBSD](/openbsd/) 6.3_

# Generate random string with random(4)

The **urandom** device produces high quality pseudo-random output
data.

> "Never use `/dev/random`. On OpenBSD, it does the same as
`/dev/urandom`, but on many other systems, it misbehaves.  For
example, it may block, directly return entropy instead of using a
stream cipher, or only return data from hardware random
generators."<br>&mdash;
[random(4)](https://man.openbsd.org/random.4)

## Limit character set

Keep characters you need and exclude everything else
[tr(1)](https://man.openbsd.org/tr.1). For example, keep characters
from `1` to `6`.

<pre>
$ <b>tr -cd 1-6 < /dev/urandom</b>
4135234354265156412324163535634456635452512413235
163421554662651365144426161433312335
<b>^C</b>
$
</pre>

## Trim

[fold(1)](https://man.openbsd.org/fold.1) into twenty-character
wide lines, then [head(1)](https://man.openbsd.org/head.1) the first
line:

<pre>
$ <b>tr -cd 1-6 < /dev/urandom |</b>
> <b>fold -w 20 |</b>
> <b>head -n 1</b>
15521625233645245322
$
</pre>

Another way to take first 20 characters, use
[dd(1)](https://man.openbsd.org/dd.1):

<pre>
$ <b>tr -cd 1-6 < /dev/urandom |</b>
> <b>echo $(dd count=20 bs=1 status=none)</b>
35611246252555226656
$
</pre>

## Adjust character set

Use any range of characters. For, example from the first printable
char, _space_, to _tilde_.

<pre>
$ <b>tr -cd ' -~' < /dev/urandom |</b>
> <b>fold -w 20 | head -n 1</b>
a(k#$(K ?I?d!^NM^(5x
$
</pre>

Or all _alphanumeric_ characters, _comma_, and _dot_.

<pre>
$ <b>tr -cd [:alnum:],. < /dev/urandom |</b>
> <b>fold -w 20 | head -n 1</b>
3zgoNRosNuznXUxzENI.
$
</pre>

## Or just use jot(1)

Run [jot(1)](https://man.openbsd.org/jot.1) with the option `-r` to print random numbers.

<pre>
$ <b>jot -r 3</b>
95
23
58
$
</pre>

Set the range from 32 to 126 ([ASCII](https://man.openbsd.org/ascii.7)
codes of _space_ and _tilde_), print a character represented by
this number (`-c`), and separate characters with an empty string
(`-s ''`).

<pre>
$ <b>jot -rcs '' 20 32 126</b>
L(k&C%M{E}7FFT9*H5tt
$
</pre>

## Or use openssl(1)

[openssl(1)](https://man.openbsd.org/openssl.1) with `rand` command
outputs pseudo-random bytes and with the `-base64` option it encodes
the output to its printable form.

<pre>
$ <b>openssl rand -base64 20</b>
zM+i3ms6UGh8TkS4azknU+ncMIY=
$
</pre>

> "I'd be wary of using openssl(1)&rarr;[Base64](https://en.wikipedia.org/wiki/Base64#Output_padding) unless you know that "=" can only come at the end because it's used as padding and so it's not adding anything extra to the password's entropy."<br>&mdash;
[Tim Chase](https://twitter.com/gumnos/status/1045268053997617153 "27 Sep 2018")
(@gumnos)

## See also

[diceware](diceware.html), [pass](pass.html)

---

**Thanks** to
[David Dahlberg](https://twitter.com/DahlbergCgn/status/1044909647310794752),
[Tim Chase](https://mobile.twitter.com/gumnos/status/1044907834432016384),
[Bojan Nastic](https://mobile.twitter.com/bnastic/status/1044891171615625217),
[horia](https://bsd.network/@horia/100791722609427845),
[Ben Bai](https://twitter.com/ben_bai/status/1044986145900253185)
for the hints, and to
[Theo de Raadt](http://www.openbsd.org/papers/hackfest2014-arc4random/index.html)
for arc4random.
