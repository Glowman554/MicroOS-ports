set -e

source tools/filething.sh

UPLOAD_SERVER="https://filething.toxicfox.de"
UPLOAD_AUTH_TOKEN="$MICROOS_UPLOAD_TOKEN"

INITRD=https://filething.toxicfox.de/files/717eb60f-c773-408f-991a-a2e06175af4d.saf
KERNEL=https://filething.toxicfox.de/files/15dfe784-82ca-4b5f-8d0a-3087dcc89663.elf
SYMBOLS=https://filething.toxicfox.de/files/bc0ee3e4-dbfd-4543-84f4-c8c912292897.syms

bash inject.sh $INITRD

response=$(upload_file "inject/modified.saf")

curl -sS -X POST "https://toxicfox.de/api/v1/microos/build" \
    -H "Content-Type: application/json" \
    -H "Authentication: $MICROOS_BUILD_TOKEN" \
    -d "{\"preset\":\"ports\",\"kernel\":\"$KERNEL\",\"symbols\":\"$SYMBOLS\",\"initrd\":\"$response\"}"