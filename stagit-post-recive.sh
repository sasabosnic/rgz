#!/bin/sh
set -e
LC_CTYPE="en_US.UTF-8"
export LC_CTYPE

[ -n "$REPOSDIR" ] || { echo "export REPOSDIR"; exit 1; }

name=$(basename $(pwd))
dir="${REPOSDIR}/${name}"
htmldir="/var/www/src"
stagitdir="/"
destdir="${htmldir}${stagitdir}"

[ ! -d "$dir" ] && { echo "$dir does not exist" >&2; exit 1; }

cd "$dir" || exit 1

force=0
while read -r old new ref; do
	[ "$old" = '0000000000000000000000000000000000000000' ] && continue
	[ "$new" = '0000000000000000000000000000000000000000' ] && continue
	hasrevs=$(git rev-list "$old" "^$new" | sed 1q)
	[ -n "${hasrevs}" ] && { force=1; break; }
done

r=$(basename "$name")
d=$(basename "$name" ".git")
printf "[%s] stagit HTML pages... " "$d"
mkdir -p "${destdir}${d}"
cd "${destdir}${d}" || exit 1
[ "$force" = "1" ] && rm -rf "commit"

stagit "${REPOSDIR}/$r"
ln -sf log.html index.html
ln -sf ../style.css style.css
ln -sf ../logo.png logo.png
[ -d "${destdir}${d}/raw" ] && rm -rf "${destdir}${d}/raw"
git clone --depth 1 "${REPOSDIR}/$r" "${destdir}${d}/raw"
echo "[stagit] done"

