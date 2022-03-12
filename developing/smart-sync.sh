#!/bin/bash

# Atualizando parametros de .gitconfig
git config --global user.name "sandrodias-devsecops"
git config --global user.email sandrodias.oficiall@gmail.com
git config --global color.ui true
git config --global core.editor code 
clear

#echo -e "\n\n   - Sua configuração atual no .gitconfig é:\n\n"
#cat /home/sandro/.gitconfig

cd /home/sandro/Github/smart-infra

git add *

echo "Escreva a descrição desse commit: " ; read texto_commit

git commit -m "texto_commit"

git push

git pull

