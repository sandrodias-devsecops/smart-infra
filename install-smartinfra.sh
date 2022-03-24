#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Bash para automação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias@gmail.com
#
# Caminho Absoluto: /smart-infra/install-smart-infra.sh
# Função: Levantar informações cruciais sobre o sistema, rede e etc guardando-as em variáveis
# Atualizado em: 24/03/2022
# Versao: 0.5
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
# Fase 8 - 
# Fase 9 - 
# Fase 10 -
#
##############################
# Variáveis Declaradas

# Respostas sobre as Fases da Instalação
# Fase 0 - Testa se Smart Infra foi instalada antes
        IfInstalled_CompletedStep=$(echo -e "Teste de Possível instalação Anterior         [ Concluído. ]")
          IfInstalled_FailureStep=$(echo -e "Teste de Possível instalação Anterior         [ Falhou.... ]")
           IfInstalled_RunningStep=(echo -e "Teste de Possível instalação Anterior         [ Executando ]")
# Fase 1 - Cria a Árvore de Diretórios que será usada na Smart Infra
            MakeDir_CompletedStep=$(echo -e "Árvore de Diretórios Criada                   [ Concluído. ]")
             MakeDir_FailuredStep=$(echo -e "Falha na Criação da Árvore de Diretórios      [ Falhou.... ]")
               MakeDir_RunningStep=(echo -e "Criando Árvore de Diretórios                  [ Executando ]")
# Fase 2 - Busca Informações da rede para Testar Conexões com a Internet
    TestConnections_CompletedStep=$(echo -e "Teste de Conexões de rede                     [ Concluído. ]")
      TestConnections_FailureStep=$(echo -e "Teste de Conexões de rede                     [ Falhou.... ]")
       TestConnections_RunningStep=(echo -e "Buscando Informações da rede                  [ Executando ]")
# Fase 3 - Atualiza os Repositórios cadastrados
          AptUpdate_CompletedStep=$(echo -e "Repositórios e Lista de pacotes Atualizados   [ Concluído. ]")
           AptUpdate_FailuredStep=$(echo -e "Atualização do Repositórios de pacotes        [ Falhou.... ]")
             AptUpdate_RunningStep=(echo -e "Atualizando Repositórios e Lista de pacotes   [ Executando ]")
# Fase 4 - Atualiza o Sistema Operacional
     AptDistUpgrade_CompletedStep=$(echo -e "Sistema Operacional Atualizado                [ Concluído. ]")
       AptDistUpgrade_FailureStep=$(echo -e "Atualização do Sistema Operacional            [ Falhou.... ]")
        AptDistUpgrade_RunningStep=(echo -e "Atualizando o Sistema Operacional             [ Executando ]")
# Fase 5 - Instala Pacotes Essenciais ao Uso inicial da Smart Infra
InstallRequirements_CompletedStep=$(echo -e "Instalação de Pacotes Essenciais no Sistema   [ Concluído. ]")
  InstallRequirements_FailureStep=$(echo -e "Instalação de Pacotes Essenciais no Sistema   [ Falhou.... ]")
   InstallRequirements_RunningStep=(echo -e "Instalando Pacotes Essenciais ao Ambiente     [ Executando ]")
# Fase 6 - Clona o Repositório Smart Infra do Github
      CloningGithub_CompletedStep=$(echo -e "Clone do Repositório Smart Infra do GitHub    [ Concluído. ]")
        CloningGithub_FailureStep=$(echo -e "Clone do Repositório Smart Infra do GitHub    [ Falhou.... ]")
         CloningGithub_RunningStep=(echo -e "Clonando Projeto Smart Infra do GitHub        [ Executando ]")
# Fase 7 - Instala os Scripts que foram clonados
     SmartResources_CompletedStep=$(echo -e "Instalação de Recursos da Smart Infra         [ Concluído. ]")
       SmartResources_FailureStep=$(echo -e "Instalação de Recursos da Smart Infra         [ Falhou.... ]")
        SmartResources_RunningStep=(echo -e "Instalando os Recursos da Smart Infra         [ Executando ]")
# Fase 8
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
				echo -e "  No dia $date_installed foi feita a Instalação até a fase de criação de Pastas.\n" && read -p "Pressione ENTER para continuar..." && rm -rf /smart-infra/;;
			F3)
				echo -e "  No dia $date_installed foi feita a Instalação até a fase de atualização dos Repositórios.\n" && read -p "Pressione ENTER para continuar..." && rm -rf /smart-infra/;;	
			F4)
				echo -e "  No dia $date_installed foi feita a Instalação até a fase de atualização do Sistema.\n" && read -p "Pressione ENTER para continuar..." && rm -rf /smart-infra/;;	
			F5)
				echo -e "  No dia $date_installed foi feita a Instalação até a fase de instalação de pacotes essenciais.\n";;	
			F6)
				echo -e "  No dia $date_installed foi feita a Instalação até a fase de instalação de clonagem do repositório.\n";;	
			F7)
				echo -e "  No dia $date_installed foi feita a Instalação até a fase de instalação dos scripts.\n";;
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
	sudo mkdir /smart-infra
	sleep 0.2
	echo -e "     ┌────────────────────────────────────────┬────────────────────────┐"
	echo -e "             /smart-infra                     │          Add"
	sudo mkdir /smart-infra/aboutme
	sleep 0.2
	echo -e "                ├> /aboutme                   │          Add"
	sudo mkdir /smart-infra/begin
	sleep 0.2
	echo -e "                ├> /begin                     │          Add"
	sudo mkdir /smart-infra/deploy
	sleep 0.2
	echo -e "                ├> /deploy                    │          Add"
	sudo mkdir /smart-infra/deploy/implanted
	sleep 0.2
	echo -e "                │     └> /implanted           │          Add"
	sudo mkdir /smart-infra/developing
	sleep 0.2
	echo -e "                ├> /developing                │          Add"
	sudo mkdir /smart-infra/discovery
	sleep 0.2
	echo -e "                ├> /discovery                 │          Add"
	sudo mkdir /smart-infra/logs
	sleep 0.2
	echo -e "                └> /logs                      │          Add"
	sudo mkdir /smart-infra/logs/status
	sleep 0.2
	echo -e "                      └> /status              │          Add"
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
echo "Hello World"
}
# Fase 3 - Atualiza os Repositórios cadastrados
 function_AptUpdate() {
echo "Hello World"
}
# Fase 4 - Atualiza o Sistema Operacional
 function_AptDistUpgrade () {
echo "Hello World"
}
# Fase 5 - Instala Pacotes Essenciais ao Uso inicial da Smart Infra
 function_InstallRequirements() {
echo "Hello World"
}
# Fase 6 - Clona o Repositório Smart Infra do Github
 function_CloningGithub() {
echo "Hello World"
}
# Fase 7 - Instala os Scripts que foram clonados
 function_SmartResources() {
echo "Hello World"
}
# Fase 8 - 
# Fase 9 - 
# Fase 10 -
##############################
#
# Rascunho das Fases

# Fase 0 - Testa se Smart Infra foi instalada antes
function_IfInstalled
# Fase 1 - Cria a Árvore de Diretórios que será usada na Smart Infra
function_MakeDir
# Fase 2 - Busca Informações da rede para Testar Conexões com a Internet
# Fase 3 - Atualiza os Repositórios cadastrados
# Fase 4 - Atualiza o Sistema Operacional
# Fase 5 - Instala Pacotes Essenciais ao Uso inicial da Smart Infra
# Fase 6 - Clona o Repositório Smart Infra do Github
# Fase 7 - Instala os Scripts que foram clonados
# Fase 8 - 
# Fase 9 - 
# Fase 10 -
#
##############################
#
# 
	clear
	echo -e "\n Terminal aguardando comandos\n"
	exit