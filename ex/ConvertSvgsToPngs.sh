#!/usr/bin/env bash
# options=("Circle" "Rounded square" "Squircle" "Teardrop" "Hexagon" "Pentagon")
# select opt in "${options[@]}"
# do
#     case $opt in
#         "Circle")
#             echo "you chose choice 1"
#             ;;
#         "Rounded square")
#             echo "you chose choice 2"
#             ;;
#         "Squircle")
#             echo "you chose choice $REPLY which is $opt"
#             ;;
#         "Teardrop")
#             break
#             ;;
#         *) echo "invalid option $REPLY";;
#     esac
# done
# read shape
# mkdir $shape
shape = "Circle"
path = "PNGs/${shape}"
mkdir "${path}"
for f in *.svg; do
     inkscape -z -e "${f%.svg}".temp.png -w 1108 -h 1108 "$f"
     gm composite -compose CopyOpacity IconMasks.png "${f%.svg}".temp.png "${f%.svg}".png
     rm "${f%.svg}".temp.png
done

