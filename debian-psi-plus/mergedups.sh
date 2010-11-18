#!/bin/bash
export LC_ALL=C

cd `dirname $0`

diff psi-plus psi-plus-webkit -NPrqs | awk '/identical/ {print $2}' | sed 's|psi-plus/||' | grep -v psi.xpm | grep -v psi.desktop > files.diff
#создаем структуру каталогов
cat files.diff | xargs -I'{}' dirname {} | sort | uniq | xargs -I'{}' mkdir -p psi-plus-common/{}
#копируем файлы
cat files.diff | xargs -I'{}' cp psi-plus/{} psi-plus-common/{}
cat files.diff | xargs -I'{}' rm psi-plus/{}
cat files.diff | xargs -I'{}' rm psi-plus-webkit/{}
find . -empty -delete
rm files.diff
