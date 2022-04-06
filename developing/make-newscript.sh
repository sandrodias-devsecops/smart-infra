#!/bin/bash
####### 
####### PROJETO:     $ProjectName
####### HOSPEDADO:   $HostedOn
####### AUTOR:       $AuthorScript 
####### EMAIL:       $EmailAuthor
####### 
####### SCRIPT:      $ScriptName
####### OBJETIVO:    $TargetScript  
####### CRIAÇÃO:     $CreationDate
####### VERSÃO:      $Version_Script
####### ATUALIZAÇÃO: $UpdateDate
####### 

clear

read -ep "Entre com o nome do Scrip: " newscript

echo -e "#!/bin/bash\n####### " > $newscript".sh"
chmod +x $newscript".sh"
ls -l $newscript".sh"
echo fim 

