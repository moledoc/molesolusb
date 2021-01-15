#!/bin/zsh

# README: Generate .script/ README. Generates description only for those scripts, that have README defined.

sh $HOME/.scripts/current.sh
cd $HOME/.scripts
rm -f README*

echo '# Scripts:\n\nGenerated with readmeGen script\n' > README.md
rg '# README:' * --color=never --hidden -m 1 | sed 's/# README:\|//g;s/^/\* \*\*/g;s/:/\*\*:/g' >> README.md
echo '\n# Author\n\nWritten by\nMeelis Utt' >> README.md
cd $cur
