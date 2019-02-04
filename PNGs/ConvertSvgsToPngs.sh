#!/usr/bin/env bash

mkdir "Square"
mkdir "RoundedSquare30px"
mkdir "RoundedSquare200px"
mkdir "Teardrop"
shape="Circle"
mkdir "${shape}"
rm *.svg
cp ../SVGs/*.svg ./
for svgFile in *.svg; do
     pngFile="${svgFile%.svg}.png"

     inkscape -z -e "Square/${pngFile}" -w 1108 -h 1108 "${svgFile}"
     gm composite -compose CopyOpacity ../Masks/CircleMask.png "Square/${pngFile}" "${shape}/${pngFile}"
     gm composite -compose CopyOpacity ../Masks/TeardropMask.png "Square/${pngFile}" "Teardrop/${pngFile}"
     gm composite -compose CopyOpacity ../Masks/RoundedSquare30pxMask.png "Square/${pngFile}" "RoundedSquare30px/${pngFile}"
     gm composite -compose CopyOpacity ../Masks/RoundedSquare200pxMask.png "Square/${pngFile}" "RoundedSquare200px/${pngFile}"
     rm "${svgFile}"
done
