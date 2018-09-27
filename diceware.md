_Tested on [OpenBSD](/openbsd/) 6.3 and [macOS](/macos/) 10.13_

# Generate passphrases with random(4)

[diceware](/bin/diceware) is a random passphrase generator. It uses
[random(4)][random] as a source of entropy. Make sure your operating
system provides good enough randomness.

[random]: https://man.openbsd.org/random.4

## Install

<pre>
$ <b>cd bin</b>
$ <b>ftp -V https://www.romanzolotarev.com/bin/diceware</b>
diceware     100% |********************| 18711       00:00
$ <b>chmod +x diceware</b>
</pre>

## Roll dice

On every run it generates a random passphrase, 8-word long by
default.

<pre>
$ <b>diceware</b>
guerrilla agnostic backdoor glove jealous mummy myth sloth
$ <b>diceware 20</b>
khaki hemoglobin artichoke cyclist coverless dictionary
vegetable sardine datebook ruined purse cytoplasm
absorbing narrator snapshot smitten cuticle journal
fiscally neither
$
</pre>

Pipe it to [your favorite password manager](/pass.html):

<pre>
$ <b>diceware | pass import twitter</b>
Enter pass phrase for /home/romanzolotarev/.pass/.key:
$
</pre>

## See also

[random](random.html), [pass](pass.html)

---

**Thanks** to
[Randall Munroe](https://m.xkcd.com/936/) and
[Joseph Bonneau](https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases).
