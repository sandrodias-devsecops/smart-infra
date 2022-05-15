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
# Atualizado em: 15/05/2022
# Versao: 1.1
#
##############################
#
# Declaração Variáveis
#
UncompressedSize=$(du -sh "${source}" | awk '{print $1}')
AvailableSpace=$(df -h "${destiny}" | awk '{print $4}' | sed 1d)
PartitionSpace=$(df -h "${destiny}" | awk '{print $1}' | sed 1d)
SpaceOldBackup=$(du -sh "${destiny}" | awk '{print $1}')
StartTime=$(date +%s)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# TABELA DE CÓDIGOS
#
# EFEITO NO TEXTO 
  Effect-Normal=0    # EFEITO DE NORMAL
  Effect-Bold=1      # EFEITO DE NEGRITO
  Effect-Light=2     # EFEITO DE BAIXA INTENSID
  Effect-Italic=3    # EFEITO DE ITALICO
  Effect-Underline=4 # EFEITO DE SUBLINHADO
  Effect-Blink=5     # EFEITO DE PISCANDO
  Effect-FastBlink=6 # EFEITO DE PISCA RAPIDO
  Effect-Invert=7    # EFEITO DE INVERSO
  Effect-Invisible=8 # EFEITO DE INVISIVEL
#
# COR DO TEXTO
  FG-Black=30   # COR DO TEXTO PRETO
  FG-Red=31     # COR DO TEXTO VERMELHO
  FG-Green=32   # COR DO TEXTO VERDE
  FG-Yellow=33  # COR DO TEXTO AMARELO
  FG-Blue=34    # COR DO TEXTO AZUL
  FG-Magenta=35 # COR DO TEXTO MAGENTA
  FG-Cyan=36    # COR DO TEXTO CIANO
  FG-White=37   # COR DO TEXTO BRANCO
#
# COR DO FUNDO
  BG-Black=40   # COR DO FUNDO PRETO
  BG-Red=41     # COR DO FUNDO VERMELHO
  BG-Green=42   # COR DO FUNDO VERDE
  BG-Yellow=43  # COR DO FUNDO AMARELO
  BG-Blue=44    # COR DO FUNDO AZUL
  BG-Magenta=45 # COR DO FUNDO MAGENTA
  BG-Cyan=46    # COR DO FUNDO CIANO
  BG-White=47   # COR DO FUNDO BRANCO
#
# TEMAS PRE DEFINIDOS
  ALERT-ERROR-Blink-Red-White="\e["${Effect-Blink}";"${FG-Red};"${BG-White}m"
  ALERT-ERROR-Blink-Black-White="\e["${Effect-Blink}";"${FG-Black};"${BG-White}m"
  ALERT-ERROR-Blink-White-Red="\e["${Effect-Blink}";"${FG-White};"${BG-Red}m"
  ALERT-ERROR-Blink-Black-Red="\e["${Effect-Blink}";"${FG-Black};"${BG-Red}m"
  NOTICE-="\e["${Effect-}";"${FG};"${BG-}m"
  StartCollor="\e["${Effect-}";"${FG};"${BG-}m"
  StartCollor="\e["${Effect-}";"${FG};"${BG-}m"
  StartCollor="\e["${Effect-}";"${FG};"${BG-}m"
  StartCollor="\e["${Effect-}";"${FG};"${BG-}m"
  StartCollor="\e["${Effect-}";"${FG};"${BG-}m"
  StartCollor="\e["${Effect-}";"${FG};"${BG-}m"

# ENCERRA FORMATAÇÃO DO TEXTO
EndCollor="\e[0m"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
Incremental="0"
appname=$(echo  $0 | sed 's@/smart-infra/deploy/@@' )
#
##############################
#
# Fase  0 - Cria os parâmetros usados no script
#
if [ ! $# -gt 0 ]; then
	clear
	echo -e "\n ERRO: Falta de parâmetros.\n Acrescente o -h para ajuda básica do script.\n\n EXEMPLO:\n "\$\:\>" ${StartCollor}$appname -h${EndCollor}"
	exit 1
else
	while getopts his:d:e: option; do
		case "${option}" in

		h)
			clear
			echo -e "\n DICAS DE USO DO $appname."
			echo -e "\n Você precisa informar os parâmetros obrigatórios."
			echo -e " Para Origem   : -s + "/diretorio_origem""
			echo -e " Para Destino  : -d + "/diretorio_destino""
			echo -e " Para Exclusão : -e + "/diretorio_excluido""
			echo -e "\n Já os parâmetros opcionais são usados de acordo com o cenário."
			echo -e " Para Backup Incremental : -i, sem o -i o Backup será Completo."
			echo -e "\nEXEMPLO:\n "\$\:\>" sudo $appname -s /diretorio_origem -d /diretorio_destino -e /diretorio_excluido\n"
			exit 0
			;;
		i)
			Incremental="1"
			yesterday=$(date '+%A' -d '-1 day')
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
			exclude=${OPTARG}
			;;
		esac
	done
fi

#
##############################
#
# Declaração Variáveis de Resposta
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
# Fase  1 - Verifica se os parâmetros informados estão corretos para o processo de backup.
function_CheckParam() {
	#     +-----------------------------------------------------------------+
	CheckParam_Source="Você precisa informar a opção -s seguido de um diretório de origem válido."
	CheckParam_Destiny="Você precisa informar a opção -d seguido de um diretório de destino válido."

	if [ ! -d "${source}" ]; then
		echo " "${CheckParam_Source}""
		exit 1
	elif
		[ ! -d "${destiny}" ]
	then
		echo " "${CheckParam_Destiny}""
		exit 1
	else
		echo > /dev/null
	fi
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
# Fase  2 - Verifica a existência de algum backup anterior que não foi retirado do diretório de destino e indica a liberação de espaço em disco.
function_CheckBackupOLD() {
	#     +-----------------------------------------------------------------+
CheckBackupOLD=$(ls "${destiny}" | wc -l)
if [ ! "${CheckBackupOLD}" -eq 0 ]; then
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
	tac $listtemp | awk '{print $2}' | sed 's/\.\///g' > $listdir
	sed -i 1d $listdir
	sed -i 's/§/\ /g' $listdir
	sed -i '/^'${exclude:=Omitido}'/d' $listdir
	rm -rf $listtemp
	echo -e "         Criada a lista de diretórios que serão incluídos no backup.\n\n"

}
# Fase  5 - Cria o backup e registra as ocorrências em Log para possíveis consultas posteriores.
function_CreateBackupComplete() {
	#     +-----------------------------------------------------------------+
	sleep 0.1
	echo -e "                 PREPARAÇÃO DO DIRETÓRIO DE DESTINO DO BACKUP"
	echo -e "     +-----------------------------------------------------------------+"
	sleep 0.1
	echo -e "                        ${StartCollor}Criando Backup Completo...${EndCollor}\n      Diretório de Origem  : "${source}"\n      Diretório de Destino : "${destiny}"\n      Diretório Excluído   : "${exclude:=Omitido}""
	today=$(date '+%A')	
	date_backup=$(date +-%d%h%y)
	while IFS= read -r diretorios || [ -n "${diretorios}" ]; do
		mkdir -p "${destiny}/${today^}/${diretorios}"
		chmod 777 "${destiny}/${today^}/${diretorios}"
		name_backup=$(
			echo "$diretorios" >pwd.txt
			sed -i 's/\// /g' pwd.txt
			cat pwd.txt | awk '{ printf $(NF)}'
			) 
		rm -rf pwd.txt
		cd "${source}/${diretorios}"
		find *.* -type f -print0 | xargs -0 tar -czf "${source}"/"${diretorios}"/"${name_backup}"-Completo-"${date_backup}".tar.gz --no-recursion
		mv "${source}"/"${diretorios}"/"${name_backup}"-Completo-"${date_backup}".tar.gz "${destiny}/${today^}/${diretorios}"
	done <$listdir
		rm -rf $listdir
	SizeBackup=$(du -sh "${destiny}" | awk '{print $1}')
	EndTime=$(date +%s)
	CalcTime=$(expr $EndTime - $StartTime)
	ResultTime=$(expr 10800 + $CalcTime)
	TotalTime=`date -d @$ResultTime +%H"Hrs "%M"Min "%S"Seg"`
	echo -e "          Backup concluído após $TotalTime gerando $SizeBackup de dados.\n\n"  | sed 's/00Hrs //;s/00Min //'
}
function_CreateBackupIncremental() {
	#     +-----------------------------------------------------------------+
	sleep 0.1
	echo -e "                 PREPARAÇÃO DO DIRETÓRIO DE DESTINO DO BACKUP"
	echo -e "     +-----------------------------------------------------------------+"
	sleep 0.1
	echo -e "                      ${StartCollor}Criando Backup Incremental...${EndCollor}\n      Diretório de Origem  : "${source}"\n      Diretório de Destino : "${destiny}"\n      Diretório Excluído   : "${exclude:=Omitido}""
	yesterday=$( date '+%A' -d '-1 day' )
	date_backup=$(date +-%d%h%y)
	while IFS= read -r diretorios || [ -n "$diretorios" ]; do
		mkdir -p "${destiny}/${yesterday^}/${diretorios}"
		chmod 777 "${destiny}/${yesterday^}/${diretorios}"
		name_backup=$(
			echo "$diretorios" >pwd.txt
			sed -i 's/\// /g' pwd.txt
			cat pwd.txt | awk '{ printf $(NF)}'
			)
		rm -rf pwd.txt
		cd "${source}/${diretorios}"
		find *.* -type f -mtime 1 -print0 | xargs -0 tar -czf "${source}"/"${diretorios}"/"${name_backup}"-Incremental-"${date_backup}".tar.gz --no-recursion
		mv "${source}"/"${diretorios}"/"${name_backup}"-Incremental-"${date_backup}".tar.gz "${destiny}/${yesterday^}/${diretorios}"
	done <$listdir
	rm -rf $listdir
	SizeBackup=$(du -sh "${destiny}" | awk '{print $1}')
	EndTime=$(date +%s)
	CalcTime=$(expr $EndTime - $StartTime)
	ResultTime=$(expr 10800 + $CalcTime)
	TotalTime=`date -d @$ResultTime +%H"Hrs "%M"Min "%S"Seg"`
	echo -e "      Backup Incremental concluído após $TotalTime gerando $SizeBackup de dados.\n\n"  | sed 's/00Hrs //;s/00Min //'
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
		-u "ALERT-ERRORa de Backup" \
		-m "O $appname realizou backup de "${source}" para "${destiny}" e precisa ser retirado do servidor para liberar espaco em disco!" \
		-xu ti3@altasports.com.br \
		-xp '!Q2w#E4r' \
		-o tls=yes
		-o message-charset=UTF-8
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
function_CheckParam
function_CheckSpace
function_CheckBackupOLD
function_CreateListDestiny
if [ ! $Incremental -eq 1 ]; then
	function_CreateBackupComplete 2>/dev/null
else
	function_CreateBackupIncremental 2>/dev/null
fi
#function_SendEmail | sed 's/^/\ \ \ \ \ /g'
