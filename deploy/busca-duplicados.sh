#!/bin/bash

clear
DirStart=`pwd`
#whiptail --title 'BUSCA POR ARQUIVOS DUPLICADOS - ALTA SPORTS'  --yes-button "CONTINUAR" --no-button "TROCAR O DIRETÓRIO"  --yesno "Atualmente você está no diretório $DirStart." 8 80 0
echo ""
echo "BUSCA POR ARQUIVOS DUPLICADOS - ALTA SPORTS"
echo "Atualmente você está buscando recursivamente no diretório:"
echo "$DirStart."

rdfind $DirStart > espaco_duplicado.txt
sed -i '1,9d' espaco_duplicado.txt
sed -i '$d' espaco_duplicado.txt
sed -i 's/ //g' espaco_duplicado.txt
sed -i 's/Totally,/Total de /g' espaco_duplicado.txt
sed -i 's/\GiB/\GB/g' espaco_duplicado.txt
sed -i 's/canbereduced./ em arquivos duplicados./g' espaco_duplicado.txt
sed -i 's/#//g' results.txt
sed -i 's/ Automatically //g' results.txt
sed -i 's/generated//g' results.txt
sed -i 's/ duptype/STATUS/g' results.txt
sed -i 's/id/EXCLUIR/g' results.txt
sed -i 's/depth/EXCLUIR/g' results.txt
sed -i 's/size/TAMANHO/g' results.txt
sed -i 's/device/EXCLUIR/g' results.txt
sed -i 's/inode/EXCLUIR/g' results.txt
sed -i 's/priority/EXCLUIR/g' results.txt
sed -i 's/name/NOME_E_LOCAL/g' results.txt
sed -i 's/DUPTYPE_FIRST_OCCURRENCE/Original/g' results.txt
sed -i 's/DUPTYPE_WITHIN_SAME_TREE/Duplicado.../g' results.txt
sed -i 's/ /_/g' results.txt
sed -i 's/\//;/g' results.txt
sed -i '$d' results.txt
sed -i '1i RELATORIO \DE \ARQUIVOS \DUPLICADOS \- \ALTA \SPORTS' espaco_duplicado.txt
echo "" >> espaco_duplicado.txt
cat results.txt >> espaco_duplicado.txt
rm -rf results.txt
sed -i '3d' espaco_duplicado.txt
mv espaco_duplicado.txt resultado.csv
clear
echo ""
echo "BUSCA POR ARQUIVOS DUPLICADOS - ALTA SPORTS"
echo "Relatório $DirStart/resultado.csv criado com sucesso."
echo ""
ls -lsh resultado.csv
echo ""
