#! /bin/bash

# Script de Instalação do Microsoft SQL Server no Ubuntu 18.04
# Autor: Jorge Gabriel Azevedo
# Data: 11/08/2019
# Versão: 1.0
# www.github.com/wultyc


echo ---------------------------------------------------------------------------
echo Script de instalação do MS SQL Server no Ubuntu 18.04
echo ---------------------------------------------------------------------------

echo Este script automatiza o processo de instalação do Microsoft SQL server no
echo Ubuntu 18.04. Para a execução deste script é necessario que o utilizador 
echo tenha premissões para executar o comando sudo.
echo 
echo Serão apresentadas algumas mensagens com informação sobre o progresso.
echo 
echo Obrigado por utilizar este script

#Seleção da versão a istalar
while :
do
	echo Selecione qual a versao do Microsoft SQL Server pretende istalar
	echo  [1] 2017
	echo  [2] 2019 Preview

	read -p "Versao a instalar : " ver

	if [ $ver -ge 1 -a $ver -le 2 ]
	then
		break
	else
		echo Opcao invalida!
	fi
done

#Importação da chave do repositorio
echo A importar a chave do repositorio
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

#Adicionar o repositorio ao sistema
echo A adicionar o repositório ao sistema

case "$ver" in 
  1)echo Versao 2017
	sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
	;; 
  2)echo Versao 2019 Preview
	sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-preview.list)"
	;;
  * )	echo Opcao Invalida
	;;
esac
#Atualizar os pacotes e instalar o servidor
echo Atualizando a lista de pacotes
sudo apt-get update

echo A instalar o servidor
sudo apt-get install -y mssql-server

#Informa o utilizador que a instalação esta concluida e que ele tem de fazer algumas configs
echo ---------------------------------------------------------------------------
echo O Microsoft SQL Server foi instalado com sucesso!
echo Agora sera iniciado o processo para configurar o servidor.
echo Sera pedido que indique a senho do SysAdmin \(SA\) e a edição do servidor

sudo /opt/mssql/bin/mssql-conf setup

#Verificação do estado da deamon
read -p "Pretende ver o estado do servidor (s/n)?" choice

case "$choice" in 
  s|S)	echo Estado do Microsft SQL Server
		systemctl status mssql-server --no-pager 
	;;
esac

#Instalação das ferramentas do MS SQL Server
read -p "Pretende instalar as ferramentas CLI do Microsoft SQL Server (s/n)?" choice

case "$choice" in 
  s|S)	echo Instala a chave e o repositorio
	curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
	curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list

	echo Atualiza a lista de pacotes e instala as ferramentas
	sudo apt-get update 
	sudo apt-get install mssql-tools unixodbc-dev

	echo Faz o sqlcmd/bcp acessivel atraves do shell 
	echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
	source ~/.bashrc
	;;
esac

#Instalação das ferramentas do MS SQL Server

read -p "Pretende instalar o suporte do PHP ao Microsoft SQL Server (s/n)?" choice

case "$choice" in 
  s|S)	echo A instalar o suporte ao PHP
	sudo apt-get install -y php7.1-sybase
	;;
esac

echo Instalacao concluida. Obrigado por utilizar este script.
