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
# Atualizado em: 05/05/2022
# Versao: 0.4
#
##############################
#
# Rascunho das Fases
# Fase  0 - Verifica se os parâmetros informados estão corretos para o processo de backup.
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
# Cria os parâmetros usados no script
#
if [ ! $# -gt 0 ]; then
	clear
	echo -e "\n Você precisa informar os parâmetros necessários"
	echo -e "\nPara Origem   : -s + "/diretorio_origem""
	echo -e "Para Destino  : -d + "/diretorio_destino""
	echo -e "Para Exclusão : -e + "/diretorio_excluido"\n"
	echo -e "\nEXEMPLO: sudo $0 -s /diretorio_origem -d /diretorio_destino -e /diretorio_excluido\n"

else
	while getopts hs:d:e: option; do
		case "${option}" in

		h)
			clear
			echo -e "\n Você precisa informar os parâmetros necessários"
			echo -e "\nPara Origem   : -s + "/diretorio_origem""
			echo -e "Para Destino  : -d + "/diretorio_destino""
			echo -e "Para Exclusão : -e + "/diretorio_excluido"\n"
			echo -e "\nEXEMPLO: sudo $0 -s /diretorio_origem -d /diretorio_destino -e /diretorio_excluido\n"
			;;
		s)
			source=${OPTARG}
			listtemp="${source}/temp.txt"
			listdir="${source}/diretorios.txt"
			;;
		d)
			destiny=${OPTARG}
			;;
		e)
			exclusion=${OPTARG}
			;;
		esac
	done
fi
#
##############################
#
# Declaração Variáveis
#
UncompressedSize=$(du -sh "${source}" | awk '{print $1}')
AvailableSpace=$(df -h "${destiny}" | awk '{print $4}' | sed 1d)
PartitionSpace=$(df -h "${destiny}" | awk '{print $1}' | sed 1d)
SpaceOldBackup=$(du -sh "${destiny}" | awk '{print $1}')
#
##############################
#
# Declaração Variáveis de Resposta
CheckParam_Source=""${source}" não é um diretório de origem válido."
CheckParam_Destiny=""${destiny}" não é um diretório de destino válido."

CheckCRON_CompletedStep=
CheckCRON_FailureStep=
CheckCRON_RunningStep=

CheckBackupOLD_CompletedStep=
CheckBackupOLD_FailureStep=
CheckBackupOLD_RunningStep=

CheckSpace_CompletedStep=
CheckSpace_FailureStep=
CheckSpace_RunningStep=

CreateListDestiny_CompletedStep=
CreateListDestiny_FailureStep=
CreateListDestiny_RunningStep=

CreateBackup_CompletedStep=
CreateBackup_FailureStep=
CreateBackup_RunningStep=

SendEmail_CompletedStep=
SendEmail_FailureStep=
SendEmail_RunningStep=
#
##############################
#
# Funções usadas nas Fases
function_HeaderDefault() {
	clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     │░░░░░░░ A  L  T  A        --- = ---     S  P  O  R  T  S ░░░░░░░░│\n     │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│\n     +-----------------------------------------------------------------+\n                         S M A R T     I N F R A"
 	    echo -e "                           SCRIPT  DE  BACKUP\n" # Define o Título do Script
	
}
# Fase  0 - Verifica se os parâmetros informados estão corretos para o processo de backup.
function_CheckParam() {
	#     +-----------------------------------------------------------------+
	if [ ! -d "${source}" ]; then
		echo "        "${CheckParam_Source}""
		exit 1
	elif
		[ ! -d "${destiny}" ]
	then
		echo "        "${CheckParam_Destiny}""
		exit 1
	else
		echo > /dev/null
	fi
}
# Fase  1 - Verifica o existe uma tarefa de backup cadastrada no CRON.
function_CheckCRON() {
	echo
	#     +-----------------------------------------------------------------+
}
# Fase  2 - Calcula o espaço bruto dos diretórios antes do backup e testa se há espaço suficiente para realizá-lo.
function_CheckSpace() {
	echo -e "                        AVALIAÇÃO DO ESPAÇO EM DISCO"
	echo -e "     +-----------------------------------------------------------------+"
	sleep 0.1
	echo -e "         Dir.Origem : "${source}""
	sleep 0.1
	echo -e "         Esp. Bruto : "${UncompressedSize}""
	sleep 0.1
	echo -e "         Dir.Destin : "${destiny}""
	sleep 0.1
	echo -e "         Disc.Parti : "${PartitionSpace}""
	sleep 0.1
	echo -e "         Esp.Dispon : "${AvailableSpace}"\n\n"
}
# Fase  3 - Verifica a existência de algum backup anterior que não foi retirado do diretório de destino e indica a liberação de espaço em disco.
function_CheckBackupOLD() {
	#     +-----------------------------------------------------------------+
CheckBackupOLD=$(ls "${destiny}" | wc -l)
if [ ! "${CheckBackupOLD}" -eq 0 ]; then
		#echo -e "        O diretório "${destiny}"\n        contém o backup anterior, primeiro mova os dados\n        pra liberar espaço em disco e reinicie o processo\n        de backup."
		#EmailEspaceDisc="O $0 não realizou backup de "${source}" para "${destiny}" pois o backup anterior precisa ser retirado do servidor para liberar espaco em disco!"
	    #exit 1
	sleep 0.1
	echo -e "                      DICA DE OTIMIZAÇÃO DO ESPAÇO EM DISCO"
	echo -e "     +-----------------------------------------------------------------+"
	sleep 0.1
	echo -e "       Percebi que ainda existem arquivos em disco do Backup anterior."
	echo -e "       Mova ou Apague esses arquivos para liberar até "${SpaceOldBackup}" de espaço.\n\n"
else
	echo > /dev/null
fi
}
# Fase  4 - Cria a lista de diretórios(e suas exceções se houver) que serão copiados no processo de backup.
function_CreateListDestiny() {
		#     +-----------------------------------------------------------------+
	sleep 0.1
	echo -e "                  ANÁLISE DO DIRETÓRIO DE ORIGEM DO BACKUP"
	echo -e "     +-----------------------------------------------------------------+"
	sleep 0.1
	cd $source
	du -h >$listtemp
	sed -i 's/\ /§/g' $listtemp
	tac $listtemp | awk '{print $2}' | sed 's/\.\///g' >$listdir
	sed -i 1d $listdir
	sed -i 's/§/\ /g' $listdir
	sed -i '/^'${exclusion}'/d' $listdir
	rm -rf $listtemp
	echo -e "         Criada a lista de diretórios que serão incluídos no backup.\n\n"

}
# Fase  5 - Cria o backup e registra as ocorrências em Log para possíveis consultas posteriores.
function_CreateBackup() {
	#     +-----------------------------------------------------------------+
	sleep 0.1
	echo -e "                 PREPARAÇÃO DO DIRETÓRIO DE DESTINO DO BACKUP"
	echo -e "     +-----------------------------------------------------------------+"
	sleep 0.1
	echo -e "                             Criando Backup...\n      Diretório de Origem  : "${source}"\n      Diretório de Destino : "${destiny}"\n      Diretório Excluído   : "${exclusion}""

	while IFS= read -r diretorios || [ -n "$diretorios" ]; do

		mkdir -p "${destiny}/${diretorios}"
		chmod 777 "${destiny}/${diretorios}"
		name_backup=$(
			echo "$diretorios" >pwd.txt
			sed -i 's/\// /g' pwd.txt
			cat pwd.txt | awk '{ printf $(NF)}'
		)
		rm -rf pwd.txt
		date_backup=$(date +-%d%h%y)
		cd "${source}/${diretorios}"
		find *.* -type f -print0 | xargs -0 tar -czf "${source}/${diretorios}"/"$name_backup""$date_backup".tar.gz --no-recursion
		mv "${source}/${diretorios}"/"$name_backup""$date_backup".tar.gz "${destiny}/${diretorios}"
	done <$listdir
	rm -rf $listdir
	echo -e "                      Backup concluído com sucesso!\n\n"
}
# Fase  6 - Envia email(s) para comunicar o status final do backup com os logs anexados.
function_SendEmail() {
	#     +-----------------------------------------------------------------+
	sleep 0.1
	echo -e "              RELATÓRIO DE TODO O PROCESSO DE BACKUP"
	echo -e "+-----------------------------------------------------------------+"
	echo -e "          Enviando email com os LOGs do Backup em anexo...\n"
	sendemail -f infra-ti@altasports.com.br \
		-t ti3@altasports.com.br \
		-s email-ssl.com.br:587 \
		-u "Alerta de Backup" \
		-m "O $0 realizou backup de "${source}" para "${destiny}" e precisa ser retirado do servidor para liberar espaco em disco!" \
		-xu ti3@altasports.com.br \
		-xp '!Q2w#E4r' \
		-o tls=yes
	#sleep 3
}
# Fase  7 -
# Fase  8 -
# Fase  9 -
# Fase 10 -
#
##############################
#
function_HeaderDefault
#function_CheckCRON
function_CheckParam
function_CheckSpace
function_CheckBackupOLD
function_CreateListDestiny
function_CreateBackup 2>/dev/null
function_SendEmail | sed 's/^/\ \ \ \ \ /g'
