# bin/screenshot.sh

This is a POSIX-compliant shell script.

    #!/bin/sh

It saves a screenshot to a `.png` file, copies it to a clipboard and show
its preview.

    # https://www.romanzolotarev.com/bin/screenshot.sh
    # Copyright 2018 Roman Zolotarev <hi@romanzolotarev.com>
    #
    # Permission to use, copy, modify, and/or distribute this software for any
    # purpose with or without fee is hereby granted, provided that the above
    # copyright notice and this permission notice appear in all copies.
    #
    # THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
    # WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
    # MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
    # ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
    # WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
    # ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
    # OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

It exits immediately if should an error occur or a command fail.

    set -e

It has four dependencies: slop ImageMagick xclip feh

    should_be_installed() {
      which "$1" >/dev/null 2>&1 ||
      { echo "$2 should be installed"; exit 1; }
    }

    should_be_installed slop 'slop(1)'
    should_be_installed import 'ImageMagick(1)'
    should_be_installed xclip 'xclip(1)'
    should_be_installed feh 'feh(1)'

Set `SCREENSHOT_DIR` to `$HOME/downloads`, if it's undefined.

    : "${SCREENSHOT_DIR:=$HOME/downloads}"

Slop grabs the mouse and lets you click and drag to make a selection (or
click on a window) while drawing a box around it, then prints out the
selection's dimensions (for example: `143x85+1237+365`, where 143x85 are
dimensions and 1237+365 are the origin).

`-o` disables graphics acceleration.

    area="$(slop -o)"

Set output file name to current time stamp and area.

    output="$SCREENSHOT_DIR/$(date +%Y%m%d-%H%M%S)-$area.png"

Make an actual shot of the selected area of the screen (`root` window) and
save it to a file.

    import -window root -crop "$area" "$output"

Copy the file into a clipboard.

    xclip -selection c -t image/png -i "$output"

Then finally preview the file.

    feh -.Z "$output"
