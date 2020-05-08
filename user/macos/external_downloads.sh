#!/usr/bin/env zsh
# Variables
ROOT_DIR=$(pwd);
APP_DIRECTORY="$HOME/Downloads/programas"

URL_SQUELPRO="https://sequelpro.com/builds/Sequel-Pro-Build-97c1b85783.zip"
URL_ROBOTO3T="https://download-test.robomongo.org/mac/studio-3t-robo-3t-mac-double-pack.zip"
URL_FILEZILLA="https://dl3.cdn.filezilla-project.org/client/FileZilla_3.48.0_macosx-x86.app.tar.bz2?h=AuKI8bs0j49qNvXvwqV2eQ&x=1588789575"
URL_MOZILADEV="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=osx&lang=pt-BR"
URL_ENDPOIT_SECURIRY_VPN="http://dl3.checkpoint.com/paid/5a/5a79c5ab48ce58947a15852106dd2bcd/Endpoint_Security_VPN.dmg?HashKey=1588801235_6c7ed999658851e14493e525c43616b1&xtn=.dmg"
URL_UTORRENT_WEB="https://utweb-assets.bittorrent.com/installer/uTorrentWebInstaller.pkg"

FILE_MOZILADEV="FirefoxDevEdition.dmg"
FILE_FILEZILLA="FileZilla_3.48.0_macosx-x86.app.tar.bz2"
FILE_VPN_CAMARA="Endpoint_Security_VPN.dmg"

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

wget -c $URL_FILEZILLA -O "$APP_DIRECTORY/$FILE_FILEZILLA";
wget -c $URL_MOZILADEV -O "$APP_DIRECTORY/$FILE_MOZILADEV";
wget -c $URL_ENDPOIT_SECURIRY_VPN -O "$APP_DIRECTORY/$FILE_VPN_CAMARA";

echo "User pré configurado com sucesso \n
como ultimo passo instale os apps baixados e delete a ($APP_DIRECTORY)" && open $APP_DIRECTORY;
