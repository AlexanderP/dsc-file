#!/bin/bash

#grc

LANG_OLD=""

LANG="grc"

CONTROL="control"
rm -f *.install
cp -f control.in ${CONTROL}

for i in ${LANG}
do
j=$(cat lang.txt | grep "^${i}__" | awk -F '__' '{print $2}')
cat >> ${CONTROL} << EOF
Package: tesseract-ocr-${i}
Architecture: all
Provides: tesseract-ocr-language, tesseract-ocr-lang
Depends: \${misc:Depends}
Recommends: tesseract-ocr (>= 3.99)
Replaces: tesseract-ocr-data (<< 2)
Description: tesseract-ocr language files for ${j}
 A commercial quality OCR engine originally developed at HP between 1985
 and 1995. In 1995, this engine was among the top 3 evaluated by UNLV. It
 was open-sourced by HP and UNLV in 2005. This package contains the data
 needed for processing images in a particular language.

EOF

cat >> tesseract-ocr-${i}.install << EOF
best/$(echo ${i} | sed 's/-/_/g').* usr/share/tesseract-ocr/4.00/tessdata/

EOF
done

for i in ${LANG_OLD} 
do
j=$(cat lang.txt | grep "^${i}__" | awk -F '__' '{print $2}')
cat >> ${CONTROL} << EOF
Package: tesseract-ocr-${i}
Architecture: all
Provides: tesseract-ocr-language, tesseract-ocr-lang
Depends: \${misc:Depends}
Recommends: tesseract-ocr (>= 3.04)
Replaces: tesseract-ocr-data (<< 2)
Description: tesseract-ocr language files for ${j}
 A commercial quality OCR engine originally developed at HP between 1985
 and 1995. In 1995, this engine was among the top 3 evaluated by UNLV. It
 was open-sourced by HP and UNLV in 2005. This package contains the data
 needed for processing images in a particular language.

EOF

cat >> tesseract-ocr-${i}.install << EOF
$(echo ${i} | sed 's/-/_/g').* usr/share/tesseract-ocr/4.00/tessdata/

EOF
done


