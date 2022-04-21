#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Shell Script para rodar em
# 		   Bash facilitando a implantação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias.oficiall@gmail.com
#
# Caminho Absoluto: /smart-infra/backup-custom.sh
# Função: Criar backups com o conteúdo de diretórios ignorando seus subdiretórios
# Atualizado em: 19/04/2022
# Versao: 0.1
#
##############################
#
# Rascunho das Fases
# Fase  0 - Cria as configurações necessárias ao processo de backup. 
# Fase  1 - Verifica o existe uma tarefa de backup cadastrada no CRON.
# Fase  2 - Verifica a existência de algum backup anterior que não foi retirado do diretório de destino e indica a liberação de espaço em disco.
# Fase  3 - Calcula o espaço bruto dos diretórios antes do backup e testa se há espaço suficiente para realizá-lo.
# Fase  4 - Cria a lista de diretórios(e suas exceções se houver) que serão copiados no processo de backup.
# Fase  5 - Cria o backup e registra as ocorrências em Log para possíveis consultas posteriores.
# Fase  6 - Envia email(s) para comunicar o status final do backup com os logs anexados.
# Fase  7 - 
# Fase  8 - 
# Fase  9 - 
# Fase 10 -
#
##############################
#
# Declaração Variáveis
conf_backup="/smart-infra/settings/smart.backup.conf"
source_folder=$(cat /smart-infra/settings/smart.backup.conf | grep source_folder | awk '{print $2}')
destination_folder=$(cat /smart-infra/settings/smart.backup.conf | grep destination_folder | awk '{print $2}')
exclusion=$(cat /smart-infra/settings/smart.backup.conf | grep exclusion | awk '{print $2}')
#
##############################
#
# Funções usadas nas Fases
# Fase  0 - Cria as configurações necessárias ao processo de backup.
function_ConfigBackup(){
clear
if test -f "$conf_backup" 
	then
		echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n                   P O L Í T I C A    D E    B A C K U P\n"
		echo -e     "         Atualmente você tem as seguintes configurações para backup.\n"
		echo -e     "     ┌────────────────────────────────┬────────────────────────────────┐\n               DIR ORIGEM             =        $source_folder\n                                      |\n               DIR DESTINO            =        $destination_folder\n     └────────────────────────────────┴────────────────────────────────┘\n      Arquivo de configuração: $conf_backup\n"
		echo -e     "       Deseja trocar o diretório de origem do backup?\n       Escolha \"N\" ou \"s\":"
		read YN_change_source
		case $YN_change_source in
			[Ss]) echo -e Sim ;;
			[Nn]) echo -e Não ;;
			*) echo "Digite apenas \"S\" para SIM ou \"N\"(ou somente ENTER) para NÃO"
		esac
	#else
fi
}
# Fase  1 - Verifica o existe uma tarefa de backup cadastrada no CRON.
function_CheckCRON(){
clear
		echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n                   P O L Í T I C A    D E    B A C K U P\n"
		echo -e     "         Checando possíveis tarefas de backup agendadas no CRONTAB.\n"
sleep 3
}
# Fase  2 - Verifica a existência de algum backup anterior que não foi retirado do diretório de destino e indica a liberação de espaço em disco.
function_CheckBackupOLD(){
clear
		echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n                   P O L Í T I C A    D E    B A C K U P\n"
		echo -e     "         Checando possíveis a existência de backups anteriores.\n"
sleep 3
}
# Fase  3 - Calcula o espaço bruto dos diretórios antes do backup e testa se há espaço suficiente para realizá-lo.
function_CheckSpace(){
clear
		echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n                   P O L Í T I C A    D E    B A C K U P\n"
		echo -e     "         Checando se o espaço disponível em disco é suficiente.\n"
sleep 3
}
# Fase  4 - Cria a lista de diretórios(e suas exceções se houver) que serão copiados no processo de backup.
function_CreateListDestination(){
clear
		echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n                   P O L Í T I C A    D E    B A C K U P\n"
		echo -e     "         Criando a lista de diretórios que serão copiados no backup.\n"
cd /dados
du -h > /dados/temp.txt
sed -i 's/\ /§/g' /dados/temp.txt
tac /dados/temp.txt | awk '{print $2}'| sed 's/\.\///g' > /dados/diretorios.txt
sed -i 1d /dados/diretorios.txt
sed -i 's/§/\ /g' /dados/diretorios.txt 
rm -rf /dados/temp.txt 
sleep 3
}
# Fase  5 - Cria o backup e registra as ocorrências em Log para possíveis consultas posteriores.
function_CreateBackup(){
clear
		echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n                   P O L Í T I C A    D E    B A C K U P\n"
		echo -e     "                            Executando Backup...\n"

while IFS= read -r diretorios || [ -n "$diretorios" ]
	do
#		echo -e "$diretorios \n"
		mkdir -p /backup/"$diretorios"
		chmod 777 /backup/"$diretorios" 
		name_backup=$(echo "$diretorios" > pwd.txt ;  sed -i 's/\// /g' pwd.txt; cat pwd.txt | awk '{ printf $(NF)}')
		rm -rf pwd.txt
		date_backup=$(date +-%d%h%y)
		cd /dados/"$diretorios"
		find *.* -type f -print0 |  xargs -0  tar -czf /dados/"$diretorios"/"$name_backup""$date_backup".tar.gz --no-recursion  
		mv  /dados/"$diretorios"/"$name_backup""$date_backup".tar.gz /backup/"$diretorios"
done < /dados/diretorios.txt 

rm -rf /dados/diretorios.txt 


}
# Fase  6 - Envia email(s) para comunicar o status final do backup com os logs anexados.
function_SendEmail(){
clear
		echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n                   P O L Í T I C A    D E    B A C K U P\n"
		echo -e     "                            Enviando email...\n"
sleep 3
 
}
# Fase  7 - 
# Fase  8 - 
# Fase  9 - 
# Fase 10 -
#
##############################
#

#function_ConfigBackup
#function_CheckCRON
#function_CheckBackupOLD
#function_CheckSpace
function_CreateListDestination
function_CreateBackup 2>/dev/null
#function_SendEmail
