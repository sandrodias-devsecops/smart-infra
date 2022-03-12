#!/bin/bash

# Variáveis
IP_Gateway=`/sbin/ip route | awk '/default/ { print $3 }'`
#IP_DNS=`cat /etc/resolv.conf | awk '/nameserver/ {print $2}' | awk 'NR == 1 {print; exit}'`
IP_DNS=$(systemd-resolve --status | grep "Current DNS Server:" | sed "s/ Current DNS Server: //")
IP_Address_Externo=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
IP_Address_Interno=$(ip -4 addr show dev $Interface1 | grep inet | tr -s " " | cut -d" " -f3 | head -n 1)
Interfaces=$(ip -brief token | wc -l)
Interface=$(ip -brief token | sed '2d')
Interface1=$(echo $Interface | awk '{print $NF}')
CheckSite=www.google.com
IP_Gateway_off="Sem comunicação com gateway, verifique a rede física..."
DNSok="O DNS ($IP_DNS) respondeu ao ping."
DNSoff="O DNS ($IP_DNS) não conseguiu responder, verifique se o IP do DNS está correto."
SiteOK="O site ($CheckSite) respondeu ao ping."
SiteOff="O site ($CheckSite) não respondeu ao ping, internet com falhas."
PortaOK="Teste OK, a porta ($PortaSite) está disponível em ($CheckSite)"
PortaOff="Falha no teste não consegui acessar a porta ($PortaSite) em ($CheckSite)"
PortaSite=80
prepare_phase="x"

# Funções do teste de Conexão com a internet


function function_PING_DNS
{
  tput setaf 6; echo && echo "Pingando 4x no DNS Primário ($IP_DNS) ..." && echo; tput sgr0;
  tput setaf 6; ping $IP_DNS -c 4
    if [ $? -eq 0 ]
    then

      tput setaf 6; echo && echo $DNSok ; tput sgr0;
      #Insert any command you like here
    else
      tput setaf 9; echo && echo $DNSoff >&2
      #altere aqui o resolv.conf
     exit 1
  fi
}

function function_PING_SITE
{
  tput setaf 10; echo && echo "Pingando 4x no site $CheckSite ." && echo; tput sgr0;
  tput setaf 10; ping $CheckSite -c 4

  if [ $? -eq 0 ]
    then
      tput setaf 10; echo && echo $SiteOK && echo ; tput sgr0;
      #Insert any command you like here
    else
      tput setaf 9; echo && echo $SiteOff >&2
      #Insert any command you like here
      exit 1
  fi
}

function function_TESTA_PORTA
{
  tput setaf 6; echo && echo "Tentando acessar a porta 80 em $CheckSite"; tput sgr0;
  if nc -zw1 $CheckSite  $PortaSite; then
    tput setaf 10; echo $PortaOK; 
  else
    tput setaf 9; echo $PortaOff;
  fi
}


# FASE 0 = Verifica a Fase de preparação do ambiente

if [ -f /smart-infra/logs/prepare_phase.log ]
     then
     prepare_phase=$(cat /smart-infra/logs/prepare_phase.log)
else
     mkdir -p /smart-infra/logs
     echo "0" > /smart-infra/logs/prepare_phase.log
     prepare_phase=$(cat /smart-infra/logs/prepare_phase.log)
fi

# FASE 1 = Habilita data e hora no history

clear
echo -e "\n\n     -----------------------------------------------\n     -- S  M  A  R  T   - - = - -   I  N  F  R  A --\n     -----------------------------------------------\n                             ...preparando ambiente!\n\n"
echo -e "     -1- Habilita data e hora no history\n"
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /etc/bash.bashrc 
source /etc/bash.bashrc 
echo "1" > /smart-infra/logs/prepare_phase.log
prepare_phase=$(cat /smart-infra/logs/prepare_phase.log)
sleep 1

# FASE 2 = Habilita data e hora no history

clear
echo -e "\n\n     -----------------------------------------------\n     -- S  M  A  R  T   - - = - -   I  N  F  R  A --\n     -----------------------------------------------\n                             ...preparando ambiente!\n\n"
echo    "     -1- Habilita data e hora no history     --OK--"
echo -e "     -2- Troca da senha de root\n"
if [$prepare_phase < 2] then
sudo passwd root
echo "2" > /smart-infra/logs/prepare_phase.log
prepare_phase=$(cat /smart-infra/logs/prepare_phase.log)
sleep 1
clear
echo -e "\n\n     -----------------------------------------------\n     -- S  M  A  R  T   - - = - -   I  N  F  R  A --\n     -----------------------------------------------\n                             ...preparando ambiente!\n\n"
echo    "     -1- Habilita data e hora no history     --OK--"
echo -e "     -2- Troca da senha de root              --OK--"
echo -e "     -3- Configuração da rede atual"
sleep 1
echo    "          -  IP Local  : $IP_Address_Interno       --OK--"
sleep 1
echo    "          -  IP Gateway: $IP_Gateway       --OK--"
sleep 1
echo -e "          -  IP DNS    : $IP_DNS       --OK--"
sleep 1
echo      "          -  IP Externo: $IP_Address_Externo       --OK--"
sleep 1
echo  -e  "     -4- Testa Conexões com a internet\n"

tput setaf 7; echo && echo "Pingando 4x no gateway ($IP_Gateway) para testar a saída para WAN" && echo; tput sgr0;
if [ "$IP_Gateway" = "" ]; then
    tput setaf 9; echo $IP_Gateway_off && echo ""; tput sgr0;
    exit 1
fi

ping $IP_Gateway -c 4

if [ $? -eq 0 ]
then
  tput setaf 7; echo && echo "O Gateway ($IP_Gateway) está pingando.";
  function_PING_DNS
  function_PING_SITE
  sleep 5

#  portscan

  exit 0

else
  tput setaf 9; echo && echo "Algo está errado com a LAN (Gateway $IP_Gateway inacessível)"
  function_PING_DNS
  function_PING_SITE

clear
echo -e "\n            RELATORIO DO TESTE DE CONECTIVIDADE\n \n Este host não está navegando na internet!\n"
  
  exit 1
fi


else #[$prepare_phase < 3]

echo "teste"
fi