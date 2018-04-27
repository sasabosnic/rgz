#!/bin/sh
#
# https://www.romanzolotarev.com/bin/lp_test.sh
# Copyright 2018 Roman Zolotarev <hi@romanzolotarev.com>
#

cd "$(dirname "$0")" || exit 1
counter=0; failed=0
fail() { counter=$((counter+1)); echo "no ok $counter - $1"; failed=$((failed+1)); }
pass() { counter=$((counter+1)); echo "ok $counter - $1"; }
equal() { if [ "$(echo "$1"|sha256)" = "$(echo "$2"|sha256)" ]; then pass "$3"; else fail "$3\\n$1\\n!=\\n$2"; fi; }
not_exist() { if [ ! -f "$1" ]; then pass "$2"; else fail "$2"; fi; }
describe() { echo '#'; echo "# \\033[1m$1\\033[m"; }


describe 'lp.sh with shebang'
output=$(lp.sh << EOF
# Hello world!

    #!/bin/sh
    echo 'Hello world!'
EOF
)
expected_output='Hello world!'
equal "$output" "$expected_output" 'Parsed and executed'


describe 'lp.sh without shebang'
output=$(lp.sh << EOF
# Hello world!

    echo 'Hello world!'

EOF
)
expected_output=$(cat << EOF
echo 'Hello world!'
EOF
)
equal "$output" "$expected_output" 'Parsed and printed out'


describe 'lp.sh with wrong shebang'
output=$(lp.sh << EOF
# Hello world!

    #!/wrong/shebang
    echo 'Hello world!'

EOF
)
expected_output=$(cat << EOF
#!/wrong/shebang
echo 'Hello world!'
EOF
)
equal "$output" "$expected_output" 'Parsed and printed out'


describe 'lp.sh with empty input'
output=$(echo '' | lp.sh)
expected_output=''
equal "$output" "$expected_output" 'Input ignored'


describe 'lp.sh without code blocks '
output=$(lp.sh << EOF
# Hello world
No code blocks
EOF
)
expected_output=''
equal "$output" "$expected_output" 'Input ignored'


describe 'lp.sh <input>'
tmp_file=$(mktemp)
cat > "$tmp_file" << EOF
# Hello world

    echo 'Hello world'
EOF
output=$(lp.sh "$tmp_file")
expected_output=$(cat << EOF
echo 'Hello world'
EOF
)
rm "$tmp_file"
equal "$output" "$expected_output" 'Input ignored'


echo "1..$counter"
if [ "$failed" -gt 0 ]; then echo "FAILED $failed/$counter"; else echo "PASS"; fi
