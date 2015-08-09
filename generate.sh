#!/bin/bash
set -eux
for i in `ls images/fullsize/`
do
echo ${i}
convert -thumbnail 200 images/fullsize/${i} images/thumbs/${i}
echo "<a class=\"example-image-link\" href=\"/images/fullsize/${i}\" data-lightbox=\"example-set\"><img class=\"example-image\" src=\"/images/thumbs/${i}\" alt=\\""/></a>" >> list.txt
done
cp boxed/top.html index.html
cat list.txt >> index.html
cat boxed/bottom.html >> index.html
source boxed/variables.txt
sed -i 's/@@TITLE@@/'"${TITLE}"'/g' index.html
sed -i 's/@@INTRO@@/'"${INTRO}"'/g' index.html
rm generate.sh
