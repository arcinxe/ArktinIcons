#!/usr/bin/env bash

if [ -f *.png ]; then
    rm *.png
fi

shapes=("Circle" "Square" "RoundedSquare30px" "RoundedSquare200px" "Teardrop")
for shape in "${shapes[@]}"; do
    mkdir -p ${shape}
done

foldersCount=0

for shape in "${shapes[@]}"; do
    filesCount=0
    ((foldersCount = foldersCount + 1))
    cp ../PNGs/${shape}/*.png ./
    shopt -s nullglob
    filesAmount=(../PNGs/${shape}/*.png)
    filesAmount=${#filesAmount[@]}
    echo "Converting shape: ${shape} [${foldersCount}/${#shapes[@]}]                                 "
    
    for pngFile in *.png; do
        ((filesCount = filesCount + 1))
        icoFile="${pngFile%.png}.ico"
        echo -ne "Current file ${pngFile} [${filesCount}/${filesAmount}]\033[0K\r"
        convert -background transparent ${pngFile} -define icon:auto-resize=16,32,48,64,256 "${shape}/${icoFile}"
        rm "${pngFile}"
    done
done
echo -ne "Done\033[0K\r"
echo "Done!"
