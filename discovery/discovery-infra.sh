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
# Captura a quantidade de interfaces de rede detectadas
qtd_interfaces=$(ip -brief token | wc -l)
lista_interfaces=$(ip -brief token | awk '/token/ { print $4 }')
#
# Nome das interfaces de rede detectadas com reserva de até 8 interfaces
#
interface1=$(echo $lista_interfaces | awk '{ print $1 }')
interface2=$(echo $lista_interfaces | awk '{ print $2 }')
interface3=$(echo $lista_interfaces | awk '{ print $3 }')
interface4=$(echo $lista_interfaces | awk '{ print $4 }')
interface5=$(echo $lista_interfaces | awk '{ print $5 }')
interface6=$(echo $lista_interfaces | awk '{ print $6 }')
interface7=$(echo $lista_interfaces | awk '{ print $7 }')
interface8=$(echo $lista_interfaces | awk '{ print $8 }')
# Captura o IP do Gateway usado como rota de saída para WAN
# Caso vario o S.O. não consegue acessar o Gateway
ip_gateway=$(ip route | awk '/default/ { print $3 }')
#
# Captura a interface de rede usada como rota para acessar o gateway detectado
interface_gateway=$(ip route | awk '/default/ { print $5 }')
#
# Captura o IP do DNS primário
ip_dns=$(systemd-resolve --status | grep "Current DNS Server:" | sed "s/ Current DNS Server: //")
#
# Captura o IP Externo 
ip_externo=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
#
# Captura o IP Interno 
ip_interno=$(ip -4 addr show dev $interface1 | grep inet | tr -s " " | cut -d" " -f3 | head -n 1)
#
# Define o site da Google para teste de conexão e navegação
checksite=www.google.com
#
# 