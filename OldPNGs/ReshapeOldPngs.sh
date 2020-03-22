#!/usr/bin/env bash

mkdir "RoundedSquare30px"
mkdir "RoundedSquare200px"
mkdir "Teardrop"
mkdir "Circle"

rm *.png

cp Square/*.png ./

for pngFile in *.png; do
     # pngFile="${svgFile%.svg}.png"

     # inkscape -z -e "Square/${pngFile}" -w 1108 -h 1108 "${svgFile}"
     gm composite -compose CopyOpacity ../Masks/MasksForOldPngs/CircleMask.png "Square/${pngFile}" "Circle/${pngFile}"
     gm composite -compose CopyOpacity ../Masks/MasksForOldPngs/TeardropMask.png "Square/${pngFile}" "Teardrop/${pngFile}"
     gm composite -compose CopyOpacity ../Masks/MasksForOldPngs/RoundedSquare30pxMask.png "Square/${pngFile}" "RoundedSquare30px/${pngFile}"
     gm composite -compose CopyOpacity ../Masks/MasksForOldPngs/RoundedSquare200pxMask.png "Square/${pngFile}" "RoundedSquare200px/${pngFile}"
     rm "${pngFile}"
done
