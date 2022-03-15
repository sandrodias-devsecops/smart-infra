#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Bash para automação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias@gmail.com
#
# Caminho Absoluto: /smart-infra/discovery/discovery-infra.sh
# Função: Levantar informações cruciais sobre o sistema, rede e etc guardando-as em variáveis
# Atualizado em: 14/03/2022
# Versao: 0.1
#
#
# ################### INFORMAÇÕES DA REDE ####################
#
# Captura a quantidade de interfaces de rede detectadas
QTD_Interfaces=$(ip -brief token | wc -l)
LISTA_Interfaces=$(ip -brief token | awk '/token/ { print $4 }')
#
# Nome das interfaces de rede detectadas
#
#Interface 1
INTERFACE1=$(echo $LISTA_Interfaces | awk '{ print $1 }')
#
#Interface 2
INTERFACE2=$(echo $LISTA_Interfaces | awk '{ print $2 }')
# Captura o IP do Gateway usado como rota de saída para WAN
# Caso vario o S.O. não consegue acessar o Gateway
IP_Gateway=$(ip route | awk '/default/ { print $3 }')
#
# Captura a interface de rede usada como rota para acessar o gateway detectado
INTERFACE_Gateway=$(ip route | awk '/default/ { print $5 }')
#
