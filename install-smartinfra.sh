#!/bin/bash
#
# Projeto: Smart-Infra é uma coleção de scripts em Bash para automação de infraestrutura de rede em linux.
# Hospedado:  https://github.com/sandrodias-sysadmin/smart-infra
# Autor: Sandro Dias
# E-mail: sandrodias@gmail.com
#
# Caminho Absoluto: /smart-infra/install-smart-infra.sh
# Função: Levantar informações cruciais sobre o sistema, rede e etc guardando-as em variáveis
# Atualizado em: 23/03/2022
# Versao: 0.4
#
#

# Respostas sobre as Fases da Instalação
# Fase 1
         AccessRoot_CompletedStep=$(echo -e "Assumindo Privilégios Administrativos         [ Concluído. ]")
            AccessRoot_RunningStep=(echo -e "Assumindo Privilégios Administrativos         [ Executando ]")
# Fase 2
            MakeDir_CompletedStep=$(echo -e "Criando Árvore de Diretórios                  [ Concluído. ]")
               MakeDir_RunningStep=(echo -e "Criando Árvore de Diretórios                  [ Executando ]")
# Fase 3
            InfoNet_CompletedStep=$(echo -e "Buscando Informações da rede                  [ Concluído. ]")
               InfoNet_RunningStep=(echo -e "Buscando Informações da rede                  [ Executando ]")
# Fase 4
          AptUpdate_CompletedStep=$(echo -e "Atualizando Repositórios e Lista de pacotes   [ Concluído. ]")
             AptUpdate_RunningStep=(echo -e "Atualizando Repositórios e Lista de pacotes   [ Executando ]")
# Fase 5
     AptDistUpgrade_CompletedStep=$(echo -e "Atualizando o Sistema Operacional             [ Concluído. ]")
        AptDistUpgrade_RunningStep=(echo -e "Atualizando o Sistema Operacional             [ Executando ]")
# Fase 6
InstallRequirements_CompletedStep=$(echo -e "Instalando pacotes essenciais ao ambiente     [ Concluído. ]")
   InstallRequirements_RunningStep=(echo -e "Instalando pacotes essenciais ao ambiente     [ Executando ]")
# Fase 7
      CloningGithub_CompletedStep=$(echo -e "Clonando Projeto Smart Infra do GitHub        [ Concluído. ]")
         CloningGithub_RunningStep=(echo -e "Clonando Projeto Smart Infra do GitHub        [ Executando ]")
# Fase 8
     SmartResources_CompletedStep=$(echo -e "Instalando os Recursos da Smart Infra         [ Concluído. ]")
        SmartResources_RunningStep=(echo -e "Instalando os Recursos da Smart Infra         [ Executando ]")
# Fase 9

# Fase 10

# Fase 11