/bin/sh
/home/dizzy/.config/sway/live-swaybg.sh

set -e
set -o pipefail

OPTIONS=$(getopt -o o:i:m:c: -l output:,image:,mode:,color -- "$@")
if [ $? -ne 0 ]; then
  exit 1
fi

eval set -- "$OPTIONS"

output=""
image=""
mode=""
color=""

while true; do
  case "$1" in
  -o | --output)
    output="$2"
    shift 2
    ;;
  -i | --image)
    image="$2"
    shift 2
    ;;
  -m | --mode)
    mode="$2"
    shift 2
    ;;
  -c | --color)
    color="$2"
    shift 2
    ;;
  --)
    shift
    break
    ;;
  *)
    exit 1
    ;;
  esac
done

cmd="mpvpaper $output $image"

mpv_options="--no-audio --loop-file"

case "$mode" in
stretch)
  mpv_options="$mpv_options --keepaspect=no"
  ;;
fill)
  mpv_options="$mpv_options --panscan=1.0"
  ;;
fit)
  mpv_options="$mpv_options"
  ;;
center)
  mpv_options="$mpv_options --video-unscaled=yes"
  ;;
tile)
  mpv_options="$mpv_options" # unsupported i think
  ;;
*) ;;
esac

cmd="$cmd -o \"$mpv_options\""

eval $cmd

