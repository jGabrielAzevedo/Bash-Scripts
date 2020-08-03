#!/bin/sh

# cp-git: Script para copiar um repositório GIT entre dois serviços de hospedagem
# sintaxe:
#   ./cp-git <nome do diretorio git a copiar> <URL do novo repositório>

cd $1/
git remote rename origin old_origin
git remote add origin $2
git pull origin master --allow-unrelated-histories
git push origin master -f

git remote rm old_origin
