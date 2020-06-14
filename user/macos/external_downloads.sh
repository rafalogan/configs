#!/usr/bin/env zsh
# Variables
APP_DIRECTORY="$HOME/Downloads/programas"

URL_SQUELPRO="https://sequelpro.com/builds/Sequel-Pro-Build-97c1b85783.zip"
URL_ROBOTO3T="https://download-test.robomongo.org/mac/studio-3t-robo-3t-mac-double-pack.zip"
URL_MOZILADEV="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=osx&lang=pt-BR"
URL_UTORRENT_WEB="https://utweb-assets.bittorrent.com/installer/uTorrentWebInstaller.pkg"
URL_FIRACODE="https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip"

FILE_MOZILADEV="FirefoxDevEdition.dmg"

#Execute
# maker diretory
if [ ! -d "$APP_DIRECTORY" ]; then
  echo  "Criando diretorio" && mkdir "$APP_DIRECTORY" && echo "$APP_DIRECTORY - Criado com sucesso!"
else
  echo "[$APP_DIRECTORY] - Já existe";
fi
# Downloads Custom APPS
wget -c $URL_SQUELPRO -P "$APP_DIRECTORY";
wget -c $URL_ROBOTO3T -P "$APP_DIRECTORY";
wget -c $URL_UTORRENT_WEB -P "$APP_DIRECTORY";
wget -c $URL_FIRACODE -P "$APP_DIRECTORY";

wget -c $URL_MOZILADEV -O "$APP_DIRECTORY/$FILE_MOZILADEV";
# Ending
echo "User pré configurado com sucesso \n
como ultimo passo instale os apps baixados e delete a ($APP_DIRECTORY)" && open $APP_DIRECTORY;
