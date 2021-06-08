#!/usr/bin/bash

size=( 16 24 32 48 64 72 80 96 128 144 152 167 180 192 196 256 300 512 )
file_svg="icon.svg"
file_ico="icon.ico"

inkscape=$( command -v inkscape )
convert=$( command -v convert )
identify=$( command -v identify )

png() {
  _check_file
  for i in "${size[@]}"; do
    ${inkscape} -w "${i}" -h "${i}" -b ffffff -o icon-"${i}".png "${file_svg}"
  done
}

ico() {
  _check_file
  ${convert} -density 256x256 -background "#ffffff" "${file_svg}" -define icon:auto-resize -colors 256 "${file_ico}"
  ${identify} "${file_ico}"
}

_check_file() {
  [[ -f "${file_svg}" ]] || { printf '%s does not exist!\n' "${file_svg}"; exit 1; }
}

"$@"
