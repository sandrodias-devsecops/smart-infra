#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Shell Script para rodar em
# 		   Bash facilitando a implantação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias.oficiall@gmail.com
#
# Caminho Absoluto: /smart-infra/deploy/smart.email-alert.sh
# Função: Recebe a saída padrão de um comando qualquer para enviá-la por email
# Atualizado em: 05/05/2022
# Versao: 0.4
#
function_SendEmail() {
	#     +-----------------------------------------------------------------+
	#sleep 0.1
	#echo -e "              RELATÓRIO DE TODO O PROCESSO DE BACKUP"
	#echo -e "+-----------------------------------------------------------------+"
	#echo -e "          Enviando email com os LOGs do Backup em anexo...\n"
	sendemail -f infra-ti@altasports.com.br \
		-t "ti3@altasports.com.br,sandrodias.oficiall@gmail.com" \
		-s email-ssl.com.br:587 \
		-u "Alerta de Backup" \
		-xu ti3@altasports.com.br \
		-xp '!Q2w#E4r' \
		-o tls=yes \
		-o message-charset=UTF-8
	#sleep 3
}

function_SendEmail