#!/bin/zsh

# README: Generate .script/ README. Generates description only for those scripts, that have README defined.

sh $HOME/.scripts/current.sh
cd $HOME/.scripts
rm -f README*

rg '# README:' * .* --color=never --hidden | grep -v 'grep\|einput=$(grep 'README:' * --color=never)cho\|sed' --color=never > README0.md
echo '# Scripts:\n\nGenerated with readmeGen script\n' > README.md
sed 's/^/\*\ /g' README0.md | sed 's/# README://g' >> README.md
echo '\n# Author\n\nWritten by\nMeelis Utt' >> README.md
rm README0.md
cd $cur
