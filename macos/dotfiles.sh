#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[@]}")" || exit

function link_to_dir() {
  echo -e "\\033[33m${1}\\033[m -> \\033[32m${2}\\033[0m"
  ln -Fhis "$PWD/$1" "$2"
}

function link_to_home_dir() {
  link_to_dir "../$1" "$HOME/.$1"
}

echo 'Linking files...'

touch "$HOME/.bash_sessions_disable"
echo "$HOME/.bash_sessions_disable ok"

for source in \
  'bash_profile' \
  'gitconfig' \
  'haskeline' \
  'gitignore' \
  'inputrc' \
  'mdlrc' \
  'hindent.yaml' \
  'tmux.conf'; do
  link_to_home_dir $source
done

echo 'Sourcing bash_profile, completions, prompt'
source 'bash_profile'

ln -Fhis "$PWD/proselintrc" /usr/local/Cellar/proselint/0.8.0/libexec/lib/python2.7/site-packages/proselint/.proselintrc
