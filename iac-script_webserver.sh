#!/bin/bash

echo "Atualizando e instalando pacotes..."

apt update && apt upgrade
apt install apache2 -y
apt install unzip -y

echo "Baixando a aplicação..."

cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

echo "Descomprimindo arquivos..."

unzip main.zip

echo "Copiando para o diretório da aplicação..."

cd linux-site-dio-main
cp -R * /var/www/html/

echo "Fim do script!"
