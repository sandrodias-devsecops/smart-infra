#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Bash para automação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias@gmail.com
#
# Caminho Absoluto: /smart-infra/install-smart-infra.sh
# Função: Levantar informações cruciais sobre o sistema, rede e etc guardando-as em variáveis
# Atualizado em: 29/03/2022
# Versao: 0.7
#
#
##############################
#
# Rascunho das Fases
# Fase 0 - Testa se Smart Infra foi instalada antes
# Fase 1 - Cria a Árvore de Diretórios que será usada na Smart Infra
# Fase 2 - Busca Informações da rede para Testar Conexões com a Internet
# Fase 3 - Atualiza os Repositórios cadastrados	
# Fase 4 - Atualiza o Sistema Operacional
# Fase 5 - Instala Pacotes Essenciais ao Uso inicial da Smart Infra
# Fase 6 - Clona o Repositório Smart Infra do Github
# Fase 7 - Instala os Scripts que foram clonados
# Fase 8 - Configura o cabeçalho padrão que será exibido na maioria dos scripts
# Fase 9 - 
# Fase 10 -
#
##############################
# Variáveis Declaradas

# Respostas sobre as Fases da Instalação
# Fase 0 - Testa se Smart Infra foi instalada antes
        IfInstalled_CompletedStep=$(echo -e "       Teste de Possível instalação Anterior            [ Concluído. ]")
          IfInstalled_FailureStep=$(echo -e "       Teste de Possível instalação Anterior            [ Falhou.... ]")
          IfInstalled_RunningStep=$(echo -e "       Teste de Possível instalação Anterior            [ Executando ]")
# Fase 1 - Cria a Árvore de Diretórios que será usada na Smart Infra
            MakeDir_CompletedStep=$(echo -e "       Criação da Árvore de Diretórios                  [ Concluído. ]")
             MakeDir_FailuredStep=$(echo -e "       Criação da Árvore de Diretórios                  [ Falhou.... ]")
              MakeDir_RunningStep=$(echo -e "       Criação da Árvore de Diretórios                  [ Executando ]")
# Fase 2 - Busca Informações da rede para Testar Conexões com a Internet 
    TestConnections_CompletedStep=$(echo -e "       Teste de Conexões de rede                        [ Concluído. ]")
      TestConnections_FailureStep=$(echo -e "       Teste de Conexões de rede                        [ Falhou.... ]")
      TestConnections_RunningStep=$(echo -e "       Teste de Conexões de rede                        [ Executando ]")
# Fase 3 - Atualiza os Repositórios cadastrados
          AptUpdate_CompletedStep=$(echo -e "       Atualização do Repositórios de pacotes           [ Concluído. ]")
           AptUpdate_FailuredStep=$(echo -e "       Atualização do Repositórios de pacotes           [ Falhou.... ]")
            AptUpdate_RunningStep=$(echo -e "       Atualização do Repositórios de pacotes           [ Executando ]")
# Fase 4 - Atualiza o Sistema Operacional
     AptDistUpgrade_CompletedStep=$(echo -e "       Atualização do Sistema Operacional               [ Concluído. ]")
       AptDistUpgrade_FailureStep=$(echo -e "       Atualização do Sistema Operacional               [ Falhou.... ]")
       AptDistUpgrade_RunningStep=$(echo -e "       Atualização do Sistema Operacional               [ Executando ]")
# Fase 5 - Instala Pacotes Essenciais ao Uso inicial da Smart Infra
InstallRequirements_CompletedStep=$(echo -e "       Instalação de Pacotes Essenciais no Sistema      [ Concluído. ]")
  InstallRequirements_FailureStep=$(echo -e "       Instalação de Pacotes Essenciais no Sistema      [ Falhou.... ]")
  InstallRequirements_RunningStep=$(echo -e "       Instalação de Pacotes Essenciais no Sistema      [ Executando ]")
# Fase 6 - Clona o Repositório Smart Infra do Github
      CloningGithub_CompletedStep=$(echo -e "       Clone do Repositório Smart Infra do GitHub       [ Concluído. ]")
        CloningGithub_FailureStep=$(echo -e "       Clone do Repositório Smart Infra do GitHub       [ Falhou.... ]")
        CloningGithub_RunningStep=$(echo -e "       Clone do Repositório Smart Infra do GitHub       [ Executando ]")
# Fase 7 - Instala os Scripts que foram clonados
     SmartResources_CompletedStep=$(echo -e "       Instalação de Recursos da Smart Infra            [ Concluído. ]")
       SmartResources_FailureStep=$(echo -e "       Instalação de Recursos da Smart Infra            [ Falhou.... ]")
       SmartResources_RunningStep=$(echo -e "       Instalando os Recursos da Smart Infra            [ Executando ]")
# Fase 8
   ConfigureCompany_CompletedStep=$(echo -e "       Configuração do Logo/Texto da Empresa            [ Concluído. ]")
     ConfigureCompany_FailureStep=$(echo -e "       Configuração do Logo/Texto da Empresa            [ Falhou.... ]")
     ConfigureCompany_RunningStep=$(echo -e "       Configuração do Logo/Texto da Empresa            [ Executando ]")

# Fase 9
# Fase 10
#############################
#
# Funções usadas em cada Fase da Instalação
# Fase 0 - Testa se Smart Infra foi instalada antes
 function_IfInstalled() {
	clear
    InstalledStep=/smart-infra/logs/status/installedstep.log
	if [ -e "$InstalledStep" ] ; then
		date_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $1" "$2 }' )
		phase_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $3 }' )
		echo -e "\n\n     \e[1;37;41m+-----------------------------------------------------------------+\e[m\n     \e[1;37;41m│                                                                 │\e[m\n     \e[1;37;41m│         S  M  A  R  T      --- = ---     I  N  F  R  A          │\e[m\n     \e[1;37;41m│                                                                 │\e[m\n     \e[1;37;41m+-----------------------------------------------------------------+\e[m\n     \e[1;37;41m                        A T E N Ç Ã O                              \e[m\n\n"
		echo -e " Verifiquei que houve uma instalação ou tentativa do Smart Infra neste Computador\n"
		case $phase_installed in
			F1)
				echo -e " No dia $date_installed foi feita a Instalação até a fase de criação de Pastas.\n" && read -p " Pressione ENTER para Remover a Instalação Anterior e continuar..." && rm -rf /smart-infra/ && sed -i 's/# Caminho dos Scripts da Smart Infra//g' /etc/bash.bashrc && sed -i 's/export PATH=\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin:\/snap\/bin:\/smart-infra:\/smart-infra\/aboutme:\/smart-infra\/begin:\/smart-infra\/deploy:\/smart-infra\/deploy\/implanted:\/smart-infra\/developing:\/smart-infra\/discovery:\/smart-infra\/logs:\/smart-infra\/logs\/status//g' /etc/bash.bashrc;;
			F3)
				echo -e " No dia $date_installed foi feita a Instalação até a fase de atualização dos Repositórios.\n" && read -p " Pressione ENTER para Remover a Instalação Anterior e continuar..." && rm -rf /smart-infra/ && sed -i 's/# Caminho dos Scripts da Smart Infra//g' /etc/bash.bashrc && sed -i 's/export PATH=\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin:\/snap\/bin:\/smart-infra:\/smart-infra\/aboutme:\/smart-infra\/begin:\/smart-infra\/deploy:\/smart-infra\/deploy\/implanted:\/smart-infra\/developing:\/smart-infra\/discovery:\/smart-infra\/logs:\/smart-infra\/logs\/status//g' /etc/bash.bashrc;;	
			F4)
				echo -e " No dia $date_installed foi feita a Instalação até a fase de atualização do Sistema.\n" && read -p " Pressione ENTER para Remover a Instalação Anterior e continuar..." && rm -rf /smart-infra/ && sed -i 's/# Caminho dos Scripts da Smart Infra//g' /etc/bash.bashrc && sed -i 's/export PATH=\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin:\/snap\/bin:\/smart-infra:\/smart-infra\/aboutme:\/smart-infra\/begin:\/smart-infra\/deploy:\/smart-infra\/deploy\/implanted:\/smart-infra\/developing:\/smart-infra\/discovery:\/smart-infra\/logs:\/smart-infra\/logs\/status//g' /etc/bash.bashrc;;
			F5)
				echo -e " No dia $date_installed foi feita a Instalação até a fase de instalação de pacotes essenciais.\n";;	
			F6)
				echo -e " No dia $date_installed foi feita a Instalação até a fase de instalação de clonagem do repositório.\n";;	
			F7)
				echo -e " No dia $date_installed foi feita a Instalação até a fase de instalação dos scripts.\n";;
			*)
				exit;;
		esac
		read -p "                      Pressione ENTER para SAIR..."
		clear
		echo -e "\n Terminal aguardando comandos\n"
		exit
	else
		clear
		echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           I N S T A L A Ç Ã O ...\n\n"
		echo -e "      Este Script necessita de privilégios administrativos, portanto é\n       altamente recomentado que você troque agora senha do ROOT.\n\n"
		echo "Deseja trocar a senha do ROOT agora? - Escolha 1 ou 2"
		select yn in "Sim" "Não"; do
			case $yn in
				Sim) echo -e "\n       Ok, vamos trocar a senha do ROOT" && sudo passwd root && break ;;
				Não) echo -e "\n     Ok já que não precisa, podemos continuar sem trocar a senha do ROOT\n" && break ;;
				*) echo -e "Digite apenas 1 ou 2"
			esac
		done
		read -p "  Assumindo privilégios administrativos para continuar...Pressione ENTER"
		sudo clear
	fi
}
# Fase 1 - Cria a Árvore de Diretórios que será usada na Smart Infra
 function_MakeDir() {
	clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           I N S T A L A Ç Ã O ...\n\n"
	echo -e "$IfInstalled_CompletedStep"
	echo -e "$MakeDir_RunningStep"
	echo -e "\n\n                                  --- = ---\n\n"
	echo -e "                     ÁRVORE DE DIRETÓRIOS SMART INFRA\n     +-----------------------------------------------------------------+\n"
	echo -e "             Caminho absoluto criado          -          PATH"
	echo -e "     ┌────────────────────────────────────────┬────────────────────────┐"
	sudo mkdir /smart-infra
	sleep 0.2
	echo -e "             /smart-infra                     │          Add"
	sudo mkdir /smart-infra/deploy
	sleep 0.2
	echo -e "                ├> /deploy                    │          Add"
	sudo mkdir /smart-infra/deploy/implanted
	sleep 0.2
	echo -e "                │     └> /implanted           │          Add"
	sudo mkdir /smart-infra/deploy/saved
	sleep 0.2
	echo -e "                │     └> /saved               │          Add"
	sudo mkdir /smart-infra/developing
	sleep 0.2
	echo -e "                ├> /developing                │          Add"
	sudo mkdir /smart-infra/logs
	sleep 0.2
	echo -e "                ├> /logs                      │          Add"
	sudo mkdir /smart-infra/logs/status
	sleep 0.2
	echo -e "                │     └> /status              │          Add"
	sudo mkdir /smart-infra/settings
	sleep 0.2
	echo -e "                └> /settings                  │          Add"
	echo -e "     └────────────────────────────────────────┴────────────────────────┘"
	sudo echo ""  >> /etc/bash.bashrc
	sudo echo "# Caminho dos Scripts da Smart Infra"  >> /etc/bash.bashrc
	sudo echo "export PATH=$PATH:/smart-infra:/smart-infra/aboutme:/smart-infra/begin:/smart-infra/deploy:/smart-infra/deploy/implanted:/smart-infra/developing:/smart-infra/discovery:/smart-infra/logs:/smart-infra/logs/status" >> /etc/bash.bashrc
	sudo echo ""  >> /etc/bash.bashrc
	sudo date +%d-%B-%Y" "%H:%M" F1" > /smart-infra/logs/status/installedstep.log
	echo -e "             Árvore de diretórios criada e adicionada no PATH.\n\n"
	read -p "          Agora vamos buscar informações da rede...Pressione ENTER"
}
# Fase 2 - Busca Informações da rede para Testar Conexões com a Internet
 function_TestConnections() {
	clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
	echo -e "$IfInstalled_CompletedStep"
	echo -e "$MakeDir_CompletedStep"
	echo -e "$TestConnections_RunningStep"
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
	sleep 0.2
	echo -e "     ┌─────────────────────────────┬───────────────────────────────────┐"
	echo -e "         Nome do Computador        │     $hostname"
	sleep 0.2
	echo -e "         Placas Detectadas         │     $qtd_interfaces"
	sleep 0.2
	echo -e "         Interface 1               │     $interface1"
	sleep 0.2
	echo -e "         Interface 2               │     $interface2"
	sleep 0.2
	echo -e "         Interface Usada na rede   │     $interface_usada_narede"
	sleep 0.2
	echo -e "          └> usando IP Local       │     $ip_interno"
	sleep 0.2
	echo -e "          └> usando IP Externo     │     $ip_externo"
	sleep 0.2
	echo -e "          └> usando Gateway        │     $ip_gateway"
	sleep 0.2
	echo -e "          └> usando DNS            │     $ip_dns"
	sleep 0.2
	echo -e "     └─────────────────────────────┴───────────────────────────────────┘"
	echo -e "            O relatório pode ser consultado nos arquivos de LOG."
	echo -e "\n\n                                  --- = ---\n\n"
	read -p "      Você está pronto pra atualizar os Repositórios... Pressione ENTER"
}
# Fase 3 - Atualiza os Repositórios cadastrados
 function_AptUpdate() {
	clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
	echo -e "$IfInstalled_CompletedStep"
	echo -e "$MakeDir_CompletedStep"
	echo -e "$TestConnections_CompletedStep"
	echo -e "$AptUpdate_RunningStep"
	echo -e "\n\n                                  --- = ---\n\n"
	sudo apt-get update
	date_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $1" "$2 }' )
	phase_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $3 }' )
	if [ $? = 0 ]; then
		sudo echo "$date_installed F3" > /smart-infra/logs/status/installedstep.log
	else
		echo -e " Falha na atualização do Sistema.\n\n  Verifique sua internet..."
		sudo rm -rf /smart-infra/
		read -p "         Processo de instalação foi desfeito... Pressione ENTER"
		exit
	fi
	echo -e "\n\n                                  --- = ---\n\n"
	read -p "         Processo concluído... Pressione ENTER"

}
# Fase 4 - Atualiza o Sistema Operacional
 function_AptDistUpgrade () {
	 clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
	echo -e "$IfInstalled_CompletedStep"
	echo -e "$MakeDir_CompletedStep"
	echo -e "$TestConnections_CompletedStep"
	echo -e "$AptUpdate_CompletedStep"
	echo -e "$AptDistUpgrade_RunningStep"
	echo -e "\n\n                                  --- = ---\n\n"
	sudo apt-get dist-upgrade -y
	date_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $1" "$2 }' )
	phase_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $3 }' )
	if [ $? = 0 ]; then
		sudo echo "$date_installed F4" > /smart-infra/logs/status/installedstep.log
	else
		echo -e " Falha na atualização do Sistema.\n\n  Verifique sua internet..."
		sudo rm -rf /smart-infra/
		read -p "         Processo de instalação foi desfeito... Pressione ENTER"
		exit
	fi
	echo -e "\n\n                                  --- = ---\n\n"
	read -p "     Processo de Atualização do Sistema foi concluído... Pressione ENTER"
}
# Fase 5 - Instala Pacotes Essenciais ao Uso inicial da Smart Infra
 function_InstallRequirements() {
	clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
	echo -e "$IfInstalled_CompletedStep"
	echo -e "$MakeDir_CompletedStep"
	echo -e "$TestConnections_CompletedStep"
	echo -e "$AptUpdate_CompletedStep"
	echo -e "$AptDistUpgrade_CompletedStep"
	echo -e "$InstallRequiriments_CompletedStep"
	echo -e "\n\n                                  --- = ---\n\n"
	sudo apt install -y figlet neofetch git wget curl unzip unrar bunzip sendEmail
	date_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $1" "$2 }' )
	phase_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $3 }' )
	if [ $? = 0 ]; then
		sudo echo "$date_installed F5" > /smart-infra/logs/status/installedstep.log
	else
		echo -e " Falha na atualização do Sistema.\n\n  Verifique sua internet..."
		sudo rm -rf /smart-infra/
		read -p "         Processo de instalação foi desfeito... Pressione ENTER"
		exit
	fi
		echo -e "\n\n                                  --- = ---\n\n"
		read -p " Agora vamos configurar GITHUB para baixar o Smart Infra... Pressione ENTER"
}
# Fase 6 - Clona o Repositório Smart Infra do Github
 function_CloningGithub() {
	clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
	echo -e "$IfInstalled_CompletedStep"
	echo -e "$MakeDir_CompletedStep"
	echo -e "$TestConnections_CompletedStep"
	echo -e "$AptUpdate_CompletedStep"
	echo -e "$AptDistUpgrade_CompletedStep"
	echo -e "$InstallRequirements_CompletedStep"
	echo -e "$CloningGithub_RunningStep"
	echo -e "\n\n                                  --- = ---\n\n"
	git config --global color.ui true
	git config --global core.editor vim
	read -ep " Entre com o seu usuário do GitHub: " username_github
	read -ep " Entre com o seu e-mail do GitHub: " usermail_github
	git config --global user.name "$username_github"
	git config --global user.mail "$usermail_github"
	date_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $1" "$2 }' )
	phase_installed=$(cat /smart-infra/logs/status/installedstep.log | awk '{ print $3 }' )
	echo -e "                        Credenciais usadas no GitHub"
	sleep 0.2
	echo -e "     ┌─────────────────────────────┬───────────────────────────────────┐"
	echo -e "         Projeto a ser clonado     │     https://sandrodias-sysadmin"
	echo -e "          └> quebra de linha       │     .github.io/smart-infra/"
	sleep 0.2
	echo -e "          └> tipo projeto          │     Público"
	sleep 0.2
	echo -e "         Pasta Local dos Clones    │     /github"
	sleep 0.2
	echo -e "         Usuário do GitHub         │     $username_github"
	sleep 0.2
	echo -e "         E-mail do GitHub          │     $usermail_github"
	sleep 0.2
	echo -e "     └─────────────────────────────┴───────────────────────────────────┘\n"
	sudo mkdir /github
	sudo chmod 777 /github
	cd /github
	git clone https://github.com/sandrodias-sysadmin/smart-infra.git
	if [ $? = 0 ]; then
		echo -e "\n\n                                  --- = ---\n\n"
		sudo echo "$date_installed F6" > /smart-infra/logs/status/installedstep.log
		read -p " Clone realizado... Pressione ENTER para Instalar o Smart Infra"
	else
		echo -e " Falha na Clonagem do Smart Infra.\n\n  Verifique sua internet..."
		sudo rm -rf /smart-infra/ /github/ 
		read -p "         Processo de instalação foi desfeito... Pressione ENTER"
		exit
	fi

}
# Fase 7 - Instala os Scripts que foram clonados
 function_SmartResources() {
	clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
	echo -e "$IfInstalled_CompletedStep"
	echo -e "$MakeDir_CompletedStep"
	echo -e "$TestConnections_CompletedStep"
	echo -e "$AptUpdate_CompletedStep"
	echo -e "$AptDistUpgrade_CompletedStep"
	echo -e "$InstallRequirements_CompletedStep"
	echo -e "$CloningGithub_CompletedStep"
	echo -e "$SmartResources_RunningStep"
	echo -e "\n\n                                  --- = ---\n\n"
	echo -e "                 Pacote de Scripts            -       Instalado"
	echo -e "     ┌────────────────────────────────────────┬────────────────────────┐"
	echo -e "             /smart-infra                     │          Sim"
	cp /github/smart-infra/*.sh /smart-infra/
	sleep 0.2
	echo -e "                ├> /aboutme                   │          Sim"
	cp /github/smart-infra/aboutme/*.sh /smart-infra/aboutme/
	sleep 0.2
	echo -e "                ├> /begin                     │          Sim"
	cp /github/smart-infra/begin/*.sh /smart-infra/begin/
	sleep 0.2
	echo -e "                ├> /deploy                    │          Sim"
	cp /github/smart-infra/deploy/*.sh /smart-infra/deploy/
	sleep 0.2
	echo -e "                ├> /developing                │          Sim"
	cp /github/smart-infra/developing/*.sh /smart-infra/developing/
	sleep 0.2
	echo -e "                └> /discovery                 │          Sim"
	cp /github/smart-infra/discovery/*.sh /smart-infra/discovery/
	sleep 0.2
	echo -e "     └────────────────────────────────────────┴────────────────────────┘"
	echo -e "                 A Instalação foi concluída com sucesso!"
	echo -e "\n\n                                  --- = ---\n\n"
	read -p "      Você está pronto pra atualizar os Repositórios... Pressione ENTER"
}
# Fase 8 - Configura o cabeçalho padrão que será exibido na maioria dos scripts
function_ConfigureCompany() {
	clear
	echo -e "\n\n     +-----------------------------------------------------------------+\n     │                                                                 │\n     │         S  M  A  R  T      --- = ---     I  N  F  R  A          │\n     │                                                                 │\n     +-----------------------------------------------------------------+\n                           Preparando ambiente...\n\n"
	echo -e "$IfInstalled_CompletedStep"
	echo -e "$MakeDir_CompletedStep"
	echo -e "$TestConnections_CompletedStep"
	echo -e "$AptUpdate_CompletedStep"
	echo -e "$AptDistUpgrade_CompletedStep"
	echo -e "$InstallRequirements_CompletedStep"
	echo -e "$CloningGithub_CompletedStep"
	echo -e "$SmartResources_CompletedStep"
	echo -e "$ConfigureCompany_RunningStep"
	echo -e "\n\n                                  --- = ---\n\n"
	read -ep "  Qual é o nome da empresa: " empresa && echo &&  figlet "     $empresa" && echo -e "     +-----------------------------------------------------------------+\n"
	read -p "ENTER"
}
# Fase 9 - 
# Fase 10 -
##############################
#
# Rascunho das Fases

# Fase 0 - Testa se Smart Infra foi instalada antes
#function_IfInstalled
# Fase 1 - Cria a Árvore de Diretórios que será usada na Smart Infra
#function_MakeDir
# Fase 2 - Busca Informações da rede para Testar Conexões com a Internet
#function_TestConnections
# Fase 3 - Atualiza os Repositórios cadastrados
#function_AptUpdate
# Fase 4 - Atualiza o Sistema Operacional
#function_AptDistUpgrade
# Fase 5 - Instala Pacotes Essenciais ao Uso inicial da Smart Infra
#function_InstallRequirements
# Fase 6 - Clona o Repositório Smart Infra do Github
#function_CloningGithub
# Fase 7 - Instala os Scripts que foram clonados
#function_SmartResources
# Fase 8 -
#function_ConfigureCompany 
# Fase 9 - 
# Fase 10 -
#
##############################
#

	clear
	echo -e "\n Terminal aguardando comandos\n"
	exit