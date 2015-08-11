#!/bin/bash
set -eux
type convert >/dev/null 2>&1 || { echo >&2 "I require convert but it's not installed.  Aborting."; exit 1; }

for i in `ls output/images/fullsize/`
do
echo ${i}
convert -thumbnail 200 output/images/fullsize/${i} output/images/thumbs/${i}
echo "<a class=\"example-image-link\" href=\"/images/fullsize/${i}\" data-lightbox=\"example-set\"><img class=\"example-image\" src=\"/images/thumbs/${i}\" alt=\\""/></a>" >> list.txt
done
cp boxed/top.html output/index.html
cat list.txt >> output/index.html
cat boxed/bottom.html >> output/index.html
source boxed/variables.txt
sed -i 's/@@TITLE@@/'"${TITLE}"'/g' output/index.html
sed -i 's/@@INTRO@@/'"${INTRO}"'/g' output/index.html
rm list.txt
