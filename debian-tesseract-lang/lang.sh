#!/bin/bash

LANG="bul cat ces  dan deu  ell eng fin fra hun ind ita lav lit nld nor pol por ron rus slk slv spa srp swe tur ukr vie chi-sim chi-tra amh asm aze-cyrl bod bos ceb cym dzo fas gle guj hat iku jav kat kat-old kaz khm kir lao lat mar mya nep ori pan pus san sin srp-latn syr tgk tir uig urd uzb uzb-cyrl yid afr ara aze bel ben chr enm epo est eus frk frm glg heb hin hrv isl ita-old jpn kan kor mal mkd mlt msa spa-old sqi swa tam tel tha"
LANG_NEW="bre chi-sim-vert chi-tra-vert cos div fao fil fry gla hye jpn-vert kor-vert kur-ara ltz mon mri oci que snd sun tat ton yor"
SCRIPT="arab armn beng cans cher cyrl deva ethi frak geor grek gujr guru hans hans-vert hant hant-vert hang hang-vert hebr jpan jpan-vert knda khmr laoo latn mlym mymr orya sinh syrc taml telu thaa thai tibt viet"

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
 needed for processing images in the ${j} language.

EOF

cat >> tesseract-ocr-${i}.install << EOF
$(echo ${i} | sed 's/-/_/g').* usr/share/tesseract-ocr/4.00/tessdata/

EOF
done

dependencies osd >> ${CONTROL} << EOF
Package: tesseract-ocr-osd
Architecture: all
Provides: tesseract-ocr-language, tesseract-ocr-lang
Depends: \${misc:Depends}
Recommends: tesseract-ocr (>= 3.99)
Breaks: tesseract-ocr (<< 3.99)
Replaces: tesseract-ocr-data (<< 2)
Description: tesseract-ocr language files for script and orientation
 Tesseract is an open source Optical Character Recognition (OCR)
 Engine. It can be used directly, or (for programmers) using an API to
 extract printed text from images. This package contains the data
 needed for identifying script and orientation.

EOF

cat >> tesseract-ocr-osd.install << EOF
$(echo osd | sed 's/-/_/g').* usr/share/tesseract-ocr/4.00/tessdata/

EOF

for i in ${SCRIPT}; do
j=$(cat script.txt | grep "^${i}__" | awk -F '__' '{print $3}')
dependencies $i >> ${CONTROL} << EOF
Package: tesseract-ocr-script-${i}
Architecture: all
Provides: tesseract-ocr-language, tesseract-ocr-lang
Depends: \${misc:Depends}
Recommends: tesseract-ocr (>= 3.99)
Breaks: tesseract-ocr (<< 3.99)
Replaces: tesseract-ocr-data (<< 2)
Description: tesseract-ocr script files for ${j}
 Tesseract is an open source Optical Character Recognition (OCR)
 Engine. It can be used directly, or (for programmers) using an API to
 extract printed text from images. This package contains the data
 needed for processing images in the ${j} script.

EOF

cat >> tesseract-ocr-script-${i}.install << EOF
$(cat script.txt | grep "${i}__" | awk -F '__' '{print $2}') usr/share/tesseract-ocr/4.00/tessdata/

EOF
done

