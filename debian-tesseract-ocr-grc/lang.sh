#!/bin/bash

LANG="grc"

CONTROL="control"
rm -f *.install
cp -f control.in ${CONTROL}


# See https://github.com/tesseract-ocr/tessdata_best/pull/17
dependencies() {
  case "$1" in
    aze)
      sed 's/${misc:Depends}/&, tesseract-ocr-aze-cyrl (>= 3.99)/g'
      ;;
    uzb)
      sed 's/${misc:Depends}/&, tesseract-ocr-uzb-cyrl (>= 3.99)/g'
      ;;
    aze-cyrl)
      sed 's/Recommends.*/&, tesseract-ocr-aze (>= 3.99)/g'
      ;;
    uzb-cyrl)
      sed 's/Recommends.*/&, tesseract-ocr-uzb (>= 3.99)/g'
      ;;
    srp-latn)
      sed 's/${misc:Depends}/&, tesseract-ocr-srp (>= 3.99)/g'
      ;;
    *)
      cat
      ;;
  esac
}


for i in ${LANG} ${LANG_NEW}; do
j=$(cat lang.txt | grep "^${i}__" | awk -F '__' '{print $2}')
dependencies $i >> ${CONTROL} << EOF
Package: tesseract-ocr-${i}
Architecture: all
Provides: tesseract-ocr-language, tesseract-ocr-lang
Depends: \${misc:Depends}
Recommends: tesseract-ocr (>= 3.99)
Breaks: tesseract-ocr (<< 3.99)
Replaces: tesseract-ocr-data (<< 2)
Description: tesseract-ocr language files for ${j}
 Tesseract is an open source Optical Character Recognition (OCR)
 Engine. It can be used directly, or (for programmers) using an API to
 extract printed text from images. This package contains the data
 needed for processing images in ${j} language.

EOF

cat >> tesseract-ocr-${i}.install << EOF
$(echo ${i} | sed 's/-/_/g').* usr/share/tesseract-ocr/4.00/tessdata/

EOF
done
