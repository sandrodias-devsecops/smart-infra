#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Bash para automação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias@gmail.com
#
# Caminho Absoluto: /smart-infra/install-smart-infra.sh
# Função: Levantar informações cruciais sobre o sistema, rede e etc guardando-as em variáveis
# Atualizado em: 22/03/2022
# Versao: 0.3
#
#
clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
#
echo -e "      Este Script necessita de privilégios administrativos, portanto é\n       altamente recomentado que você troque agora senha do ROOT.\n\n"
#
echo "Deseja trocar a senha do ROOT agora?"
select yn in "Sim" "Não"; do
	case $yn in
	Sim) echo -e "\n Sim vamos trocar a senha do ROOT" && sudo passwd root && break ;;
	Não) echo -e "\n     Ok já que não precisa, podemos continuar sem trocar a senha do ROOT\n" && break ;;
	esac
done
#
read -p "  Assumindo privilégios administrativos para continuar...Pressione ENTER"

#
sudo clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
echo -e     "         Assumindo Privilégios Administrativos         [ Concluído ]"
echo -e     "         Criando Árvore de Diretórios                  [ Executando]"
echo -e "\n\n                                  --- = ---\n\n"
#     
echo -e "                     ÁRVORE DE DIRETÓRIOS SMART INFRA\n     +-----------------------------------------------------------------+\n"
#
echo -e "             Caminho absoluto criado          -          PATH"
#sudo mkdir /smart-infra
#echo -e "\n  export PATH=$PATH:/smart-infra"  >> /etc/bash.bashrc
sleep 1
echo -e "     ┌────────────────────────────────────────┬───────────────────────┐"
echo -e "     │       /smart-infra                     │          Add          │"
#sudo mkdir /smart-infra/aboutme
#echo -e "\n  export PATH=$PATH:/smart-infra/aboutme"  >> /etc/bash.bashrc
sleep 1
echo -e "     │          ├> /aboutme                   │          Add          │"
#sudo mkdir /smart-infra/begin
#echo -e "\n  export PATH=$PATH:/smart-infra/begin"  >> /etc/bash.bashrc
sleep 1
echo -e "     │          ├> /begin                     │          Add          │"
#sudo mkdir /smart-infra/deploy
#echo -e "\n  export PATH=$PATH:/smart-infra/deploy"  >> /etc/bash.bashrc
sleep 1
echo -e "     │          ├> /deploy                    │          Add          │"
#sudo mkdir /smart-infra/deploy/implanted
#echo -e "\n  export PATH=$PATH:/smart-infra/deploy/implanted"  >> /etc/bash.bashrc
sleep 1
echo -e "     │          │     └> /implanted           │          Add          │"
#sudo mkdir /smart-infra/developing
#echo -e "\n  export PATH=$PATH:/smart-infra/developing"  >> /etc/bash.bashrc
sleep 1
echo -e "     │          ├> /developing                │          Add          │"
#sudo mkdir /smart-infra/discovery
#echo -e "\n  export PATH=$PATH:/smart-infra/discovery"  >> /etc/bash.bashrc
sleep 1
echo -e "     │          ├> /discovery                 │          Add          │"
#sudo mkdir /smart-infra/logs
#echo -e "\n  export PATH=$PATH:/smart-infra/logs"  >> /etc/bash.bashrc
sleep 1
echo -e "     │          └> /logs                      │          Add          │"
#sudo mkdir /smart-infra/logs/status
#echo -e "\n  export PATH=$PATH:/smart-infra/logs/status"  >> /etc/bash.bashrc
sleep 1
echo -e "     │                └> /status              │          Add          │"
#
echo -e "     └────────────────────────────────────────┴───────────────────────┘"
echo -e "             Árvore de diretórios criada e adicionada no PATH.\n\n"
read -p "          Agora vamos buscar informações da rede...Pressione ENTER"
#echo -e "                                  --- = ---\n\n"
clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
echo -e     "         Assumindo Privilégios Administrativos         [ Concluído ]"
echo -e     "         Criando Árvore de Diretórios                  [ Concluído ]"
echo -e     "         Buscando Informações da rede                  [ Executando]"
echo -e "\n\n                                  --- = ---\n\n"
#     
echo -e "                              INFORMAÇÕES DA REDE\n     +-----------------------------------------------------------------+\n"
# ################### INFORMAÇÕES DA REDE ####################
# Captura a quantidade de interfaces de rede detectadas
#
qtd_interfaces=$(ip -brief token | wc -l)
#
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
ip_dns=$(systemd-resolve --status | grep "Current DNS Server:" | sed "s/  Current DNS Server: //")
#
# Captura o IP Externo 
ip_externo=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
#
# Captura a Interface usada na rede
interface_usada_narede=$(ip -4 addr show | grep "state UP" | awk '{ print $2 }' | sed 's/://') 
#
# Captura o IP Interno 
ip_interno=$(ip -4 addr show dev $interface_usada_narede | grep inet | tr -s " " | cut -d" " -f3 | head -n 1 | sed 's/\/24//')
#
# Define o site da Google para teste de conexão e navegação
checksite=www.google.com
#
hostname=$(hostname)
#
#
echo -e "                        Relatório geral da rede atual"
sleep 1
echo -e "     ┌─────────────────────────────┬────────────────────────────────────┐"
echo -e "         Hostname                  │     $hostname"
sleep 1
echo -e "         Placas Detectadas         │     $qtd_interfaces"
sleep 1
echo -e "         Interface 1               │     $interface1"
sleep 1
echo -e "         Interface 2               │     $interface2"
sleep 1
echo -e "         Interface Usada na rede   │     $interface_usada_narede"
sleep 1
echo -e "          └> usando IP Local       │     $ip_interno"
sleep 1
echo -e "          └> usando IP Externo     │     $ip_externo"
sleep 1
echo -e "          └> usando Gateway        │     $ip_gateway"
sleep 1
echo -e "          └> usando DNS            │     $ip_dns"
sleep 1
echo -e "     └─────────────────────────────┴────────────────────────────────────┘"
echo -e "            O relatório pode ser consultatdo nos arquivos de LOG."
echo -e "\n\n                                  --- = ---\n\n"
read -p "         Proximo passo é instalar os Pré-requisitos ...Pressione ENTER"
clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
echo -e     "         Assumindo Privilégios Administrativos         [ Concluído ]"
echo -e     "         Criando Árvore de Diretórios                  [ Concluído ]"
echo -e     "         Buscando Informações da rede                  [ Concluído ]"
echo -e     "         Atualizando Repositórios e Lista de pacotes   [ Executando]\n"
sudo apt update
echo -e "\n\n                                  --- = ---\n\n"
read -p "         Processo concluído... Pressione ENTER"

clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
echo -e     "         Assumindo Privilégios Administrativos         [ Concluído ]"
echo -e     "         Criando Árvore de Diretórios                  [ Concluído ]"
echo -e     "         Buscando Informações da rede                  [ Concluído ]"
echo -e     "         Atualizando Repositórios e Lista de pacotes   [ Concluído ]"
echo -e     "         Atualizando a Distribuição Inteira            [ Executando]\n"
#sudo apt dist-upgrade -y
echo -e "\n\n                                  --- = ---\n\n"
read -p "         Processo concluído... Pressione ENTER"

clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
echo -e     "         Assumindo Privilégios Administrativos         [ Concluído ]"
echo -e     "         Criando Árvore de Diretórios                  [ Concluído ]"
echo -e     "         Buscando Informações da rede                  [ Concluído ]"
echo -e     "         Atualizando Repositórios e Lista de pacotes   [ Concluído ]"
echo -e     "         Atualizando a Distribuição Inteira            [ Concluído ]"
echo -e     "         Instalando pacotes essenciais ao ambiente     [ Executando]\n"

#sudo apt install -y figtlet neofetch git wget curl 
echo -e "\n\n                                  --- = ---\n\n"

clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
echo -e     "         Assumindo Privilégios Administrativos         [ Concluído ]"
echo -e     "         Criando Árvore de Diretórios                  [ Concluído ]"
echo -e     "         Buscando Informações da rede                  [ Concluído ]"
echo -e     "         Atualizando Repositórios e Lista de pacotes   [ Concluído ]"
echo -e     "         Atualizando a Distribuição Inteira            [ Concluído ]"
echo -e     "         Instalando pacotes essenciais ao ambiente     [ Concluído ]"
echo -e "\n\n                                  --- = ---\n\n"
read -p     " Agora vamos configurar GITHUB para baixar o Smart Infra... Pressione ENTER"
echo

