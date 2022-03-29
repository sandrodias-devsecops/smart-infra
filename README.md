# Smart=Infra
Smart=Infra é uma coleção de scripts em Bash para automação de infraestrutura de rede em linux.

## 🚀 O Objetivo do Projeto

Com uma abordagem muito prática e dividida em pequenas partes (que juntas conseguem atender até os mais complexos cenários) o Projeto Smart=Infra pretende demonstrar os benefícios de automatizar tarefas para um SysAdmin (mais conhecido como "O carinha do TI") facilitando o dia a dia em um Data Center, deixando tempo para novas pesquisas e testes de segurança por exemplo.

## 📋 Os Pré=requisitos

***Soft Skills***
Curiosidade, Resiliência, Criatividade e Persistência são algumas softskills necessárias para a implantação prática desse projeto principalmente em um cenário real.

***Hard Skills***
Conhecimento mínimo sobre administração de sistemas linux a princípio baseados em Debian mas que logo também terá suporte a sistemas baseados em Red Hat.

### 🔧 Instalação

Partindo da premissa que já temos um servidor recém instalado e navegando na internet precisamos apenas baixar o script de instalação inicial e em seguida executá=lo pra ter acesso a toda a coleção de  scripts.

Para baixar digite:

```
wget https://github.com/sandrodias=sysadmin/smart=infra/blob/ea020bee527bae7ecc1f504ef775ccad64313e1b/install=smartinfra.sh
```

Em seguida execute com privilégios administrativos:

```
sudo ./install=smartinfra.sh
```

***FORTE RECOMENDAÇÃO:***
Antes de executar analise o código do script e faça suas adequações se for o caso, e claro teste em máquinas virtuais garantindo que não haverá riscos em um cenários real de produção.

### FASES DA INSTALAÇÃO:
A instalação foi divida em fases, até o momento são 9 no total mas que podem mudar a qualquer momento ou serem reorganizadas.

***Fase 0***
= Testa se Smart Infra foi instalada antes

***Fase 1***
= Cria a Árvore de Diretórios que será usada na Smart Infra

***Fase 2***
= Busca Informações da rede para Testar Conexões com a Internet

***Fase 3***
= Atualiza os Repositórios cadastrados

***Fase 4***
= Atualiza o Sistema Operacional

***Fase 5***
= Instala Pacotes Essenciais ao Uso inicial da Smart Infra

***Fase 6***
= Clona o Repositório Smart Infra do Github

***Fase 7***
= Instala os Scripts que foram clonados

***Fase 8***
= Configura o cabeçalho padrão que será exibido na maioria dos scripts

