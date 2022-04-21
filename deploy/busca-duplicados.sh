#!/bin/bash
source
clear
DirStart=$(pwd)
#whiptail --title 'BUSCA POR ARQUIVOS DUPLICADOS - ALTA SPORTS'  --yes-button "CONTINUAR" --no-button "TROCAR O DIRETÓRIO"  --yesno "Atualmente você está no diretório $DirStart." 8 80 0
echo ""
echo "BUSCA POR ARQUIVOS DUPLICADOS - ALTA SPORTS"
echo "Atualmente você está buscando recursivamente no diretório:"
echo "$DirStart."

rdfind $DirStart > duplicados_encontrados.csv
formula=$(`=SE([@SIZE]<=$A$3*4;"4 KB";SE([@SIZE]<$B$3;CONCATENAR(ARRED([@SIZE]/$A$3;2);" KB");SE([@SIZE]<$C$3;CONCATENAR(ARRED([@SIZE]/$B$3;2);" MB");SE([@SIZE]<$D$3;CONCATENAR(ARRED([@SIZE]/$C$3;2);" GB");CONCATENAR(ARRED([@SIZE]/$D$3;2);" TB")))))`)

sed -i '1,9d;$d;s/Totally, /Total\ de\ /;s/\ KiB/\ KB/;s/\ MiB/\ MB/;s/\ GiB/\ GB/;s/\ TiB/\ TB/;s/ can be reduced./\ em\ arquivos\ duplicados\ que\ precisam\ ser\ tratados\ no\ excel./g' duplicados_encontrados.csv
sed -i '1i RELATORIO \DE \ARQUIVOS \DUPLICADOS \- \ALTA \SPORTS' duplicados_encontrados.csv
echo -e "\nSTATUS;EXCLUIR;EXCLUIR;TAM_BYTES;TAMANHO;EXCLUIR;EXCLUIR;NOME_E_LOCAL" >> duplicados_encontrados.csv

sed -i 's/ /;/g;s/\//;/g;s/DUPTYPE_FIRST_OCCURRENCE/Arq_Original/g;s/DUPTYPE_WITHIN_SAME_TREE/Duplicado/g' results.txt
sed -i '$d' results.txt

tac results.txt >> duplicados_encontrados.csv
sed -i '$d' duplicados_encontrados.csv
sed -i '$d' duplicados_encontrados.csv

rm -rf results.txt

clear
echo ""
echo "BUSCA POR ARQUIVOS DUPLICADOS - ALTA SPORTS"
echo "Relatório $DirStart/duplicados_encontrados.csv criado com sucesso!"

echo ""
ls -lsh duplicados_encontrados.csv
echo ""