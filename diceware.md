# Strong password generator

[diceware](/bin/diceware) is a POSIX-compliant shell script. It generates
a random combination of words from the predefined list. It uses
`/dev/urandom` as the source of entropy, so make sure your operating
system provides good enough randomness.


Download and run `diceware`. Assuming `./bin` is in `PATH`.

    $ cd bin
    $ ftp https://www.romanzolotarev.com/bin/diceware
    $ chmod +x diceware
    $ diceware
    uerrilla agnostic backdoor glove jealous mummy myth sloth
    $

On every run it generates a random 8-word pass phrase. You can write this
phrase down, just memorize it, or you can pipe it to your [favorite
password manager](/pass.html):

    $ diceware | pass import twitter
    $

Each word adds about 10 bits of entropy, so for passwords use 8 words or
more. Need more words? Easy:

    $ diceware 20
    khaki hemoglobin artichoke cyclist coverless dictionary
    vegetable sardine datebook ruined purse cytoplasm
    absorbing narrator snapshot smitten cuticle journal
    fiscally neither
    $

## See also

[Diceware](https://en.m.wikipedia.org/wiki/Diceware),
[Deep Dive: EFF's New Wordlists for Random Passphrases](https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases) by Joseph Bonneau,
[xkcd: Password Strength](https://m.xkcd.com/936/)
