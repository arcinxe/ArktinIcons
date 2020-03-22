#!/usr/bin/env bash

if [ -f *.png ]; then
    rm *.png
fi

shapes=("Circle" "Square" "RoundedSquare30px" "RoundedSquare200px" "Teardrop")
for shape in "${shapes[@]}"; do
    mkdir -p ${shape}
done

mode=1

case $1 in
-v | --vector | "")
    mode=0
    ;;

-r | --raster)
    mode=2
    ;;

-a | --all)
    mode=1
    ;;

*)
    mode=1
    ;;
esac

foldersCount=0
filesAmount=0
totalFilesCount=0
totalFilesAmount=0

oldFilesAmount=(../OldPNGs/Square/*.png)
oldFilesAmount=${#oldFilesAmount[@]}
newFilesAmount=(../PNGs/Square/*.png)
newFilesAmount=${#newFilesAmount[@]}

[[ ${mode} == 0 ]] && echo "Processing vector icons..."
[[ ${mode} == 1 ]] && echo "Processing all icons..."
[[ ${mode} == 2 ]] && echo "Processing raster icons..."

if ((mode < 2)); then
    ((filesAmount = filesAmount + newFilesAmount))
    ((totalFilesAmount = totalFilesAmount + newFilesAmount))
fi
if ((mode > 0)); then
    ((filesAmount = filesAmount + oldFilesAmount))
    ((totalFilesAmount = totalFilesAmount + oldFilesAmount))
fi
shapesAmount=${#shapes[@]}
((totalFilesAmount = totalFilesAmount * shapesAmount))

for shape in "${shapes[@]}"; do
    filesCount=0
    ((foldersCount = foldersCount + 1))
    if ((mode > 0)); then
        cp ../OldPNGs/${shape}/*.png ./
    fi
    if ((mode < 2)); then
        cp ../PNGs/${shape}/*.png ./
    fi

    shopt -s nullglob
    oldFilesAmount=(../OldPNGs/${shape}/*.png)
    oldFilesAmount=${#oldFilesAmount[@]}
    newFilesAmount=(../PNGs/${shape}/*.png)
    newFilesAmount=${#newFilesAmount[@]}

    echo "Converting shape: ${shape} [${foldersCount}/${#shapes[@]}]                                 "

    for pngFile in *.png; do
        ((filesCount = filesCount + 1))
        ((totalFilesCount = totalFilesCount + 1))
        icoFile="${pngFile%.png}.ico"
        percentage=$(bc <<< "scale=1; ${totalFilesCount} * 100 / ${totalFilesAmount}")
        echo -ne "[${percentage}% ${totalFilesCount}/${totalFilesAmount}] Current file: ${pngFile} [${filesCount}/${filesAmount}]\033[0K\r"
        convert -background transparent ${pngFile} -define icon:auto-resize=16,32,48,64,256 "${shape}/${icoFile}"
        rm "${pngFile}"
    done
done
echo -ne "Done\033[0K\r"
echo "Done!"
