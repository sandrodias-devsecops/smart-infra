#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Bash para automação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias@gmail.com
#
# Caminho Absoluto: /smart-infra/install-smart-infra.sh
# Função: Levantar informações cruciais sobre o sistema, rede e etc guardando-as em variáveis
# Atualizado em: 21/03/2022
# Versao: 0.2
#
clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     |                                                                 |\n     !         S  M  A  R  T      --- = ---     I  N  F  R  A          |\n     |                                                                 |\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"

    echo -e "      Este Script necessita de privilégios administrativos, portanto é\n       altamente recomentado que você troque agora senha do ROOT.\n\n"

echo "Deseja trocar a senha do ROOT agora?"
select yn in "Sim" "Não"; do
	case $yn in
	Sim) echo -e "\n Sim vamos trocar a senha do ROOT" && sudo passwd root && break ;;
	Não) echo -e "\n Ok já que não precisa, podemos continuar sem trocar a senha do ROOT\n" && break ;;
	esac
done

read  -p  "Pressione qualquer tecla para continuar e assumir privilégios administrativos..."

clear
echo -e " \n\n     +-----------------------------------------------------------------+\n     |                                                                 |\n     !         S  M  A  R  T      --- = ---     I  N  F  R  A          |\n     |                                                                 |\n     +-----------------------------------------------------------------+\n                           Criando Diretórios...\n\n"

echo -e "Criando árvore de diretórios Smart Infra."
echo ""
#sudo mkdir /smart-infra
#echo -e "\n  export PATH=$PATH:/smart-infra"  >> /etc/bash.bashrc
sleep 1
echo "  /smart-infra"
#sudo mkdir /smart-infra/aboutme
#echo -e "\n  export PATH=$PATH:/smart-infra/aboutme"  >> /etc/bash.bashrc
sleep 1
echo "     ├> /aboutme"
#sudo mkdir /smart-infra/begin
#echo -e "\n  export PATH=$PATH:/smart-infra/begin"  >> /etc/bash.bashrc
sleep 1
echo "     ├> /begin"
#sudo mkdir /smart-infra/deploy
#echo -e "\n  export PATH=$PATH:/smart-infra/deploy"  >> /etc/bash.bashrc
sleep 1
echo "     ├> /deploy"
#sudo mkdir /smart-infra/deploy/implanted
#echo -e "\n  export PATH=$PATH:/smart-infra/deploy/implanted"  >> /etc/bash.bashrc
sleep 1
echo "           └> /implanted"
#sudo mkdir /smart-infra/developing
#echo -e "\n  export PATH=$PATH:/smart-infra/developing"  >> /etc/bash.bashrc
sleep 1
echo "     ├> /developing"
#sudo mkdir /smart-infra/discovery
#echo -e "\n  export PATH=$PATH:/smart-infra/discovery"  >> /etc/bash.bashrc
sleep 1
echo "     ├> /discovery"
#sudo mkdir /smart-infra/logs
#echo -e "\n  export PATH=$PATH:/smart-infra/logs"  >> /etc/bash.bashrc
sleep 1
echo "     └> /logs"
#sudo mkdir /smart-infra/logs/status
#echo -e "\n  export PATH=$PATH:/smart-infra/logs/status"  >> /etc/bash.bashrc
sleep 1
echo "           └> /status"
echo -e "\nAdicionando árvore de diretórios no PATH."

read  -p  "Pressione qualquer tecla para instalar os pré-requisitos..."

clear
echo -e "\n\n     +-----------------------------------------------------------------+\n     |                                                                 |\n     !         S  M  A  R  T      --- = ---     I  N  F  R  A          |\n     |                                                                 |\n     +-----------------------------------------------------------------+\n                      Testando conexões de rede...\n\n"

source /home/sandro/Downloads/Github/smart-infra/discovery/discovery-infra.sh
    echo -e "A placa $interface_gateway com o IP: $ip_interno"
