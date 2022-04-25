  GNU nano 4.8                                                                             smart.search-duplicates                                                                                        
#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Shell Script para rodar em
#                  Bash facilitando a implantação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias.oficiall@gmail.com
#
# Caminho Absoluto: /smart-infra/smart.search-duplicates
# Função: Busca por arquivos duplicados no diretórioatual e seus subdiretórios
# Atualizado em: 20/04/2022
# Versao: 0.1
#
##############################
#
source
clear
DirStart=$1

echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n            I D E N T I F I C A D O R   D E   D U P L I C A D O S\n\n         Atualmente você está escaneando recursivamente no diretório:\n         $DirStart."


rdfind $DirStart > duplicados_encontrados.csv
formula=$(`=SE([@SIZE]<=$A$3*4;"4 KB";SE([@SIZE]<$B$3;CONCATENAR(ARRED([@SIZE]/$A$3;2);" KB");SE([@SIZE]<$C$3;CONCATENAR(ARRED([@SIZE]/$B$3;2);" MB");SE([@SIZE]<$D$3;CONCATENAR(ARRED([@SIZE]/$C$3;2);" >

sed -i '1,9d;$d;s/Totally, /Total\ de\ /;s/\ KiB/\ KB/;s/\ MiB/\ MB/;s/\ GiB/\ GB/;s/\ TiB/\ TB/;s/ can be reduced./\ em\ arquivos\ duplicados\ que\ precisam\ ser\ tratados\ no\ excel./g' duplicados_en>
sed -i '1i RELATORIO \DE \ARQUIVOS \DUPLICADOS \- \ALTA \SPORTS' duplicados_encontrados.csv
echo -e "\nSTATUS;EXCLUIR;EXCLUIR;TAM_BYTES;TAMANHO;EXCLUIR;EXCLUIR;NOME_E_LOCAL" >> duplicados_encontrados.csv

sed -i 's/ /;/g;s/\//;/g;s/DUPTYPE_FIRST_OCCURRENCE/Arq_Original/g;s/DUPTYPE_WITHIN_SAME_TREE/Duplicado/g' results.txt
sed -i '$d' results.txt

tac results.txt >> duplicados_encontrados.csv
sed -i '$d' duplicados_encontrados.csv
sed -i '$d' duplicados_encontrados.csv

rm -rf results.txt

clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n            I D E N T I F I C A D O R   D E   D U P L I C A D O S\n\n         Atualmente você está escaneando recursivamente no diretório:\n         $DirStart."

ls -lsh duplicados_encontrados.csv

echo ""


