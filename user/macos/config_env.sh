#!/usr/bin/env zsh

# Variables
ROOT_DIR=$(pwd);
APP_DIRECTORY="$HOME/Downloads/programas"

DEV_SERVICES=(
  gnupg
  git
  composer
  wget
)

APPS_BREW=(
  atom
  visual-studio-code
  phpstorm
  gitkraken
  mysqlworkbench
  docker
  postman
  google-chrome
  vlc
  adobe-creative-cloud
)



URL_HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/master/install"
URL_RVMIO_IMPORT="https://rvm.io/mpapis.asc"
URL_RVMIO="https://get.rvm.io"

REPOSITORY_COMPOSER="copy('https://getcomposer.org/installer', 'composer-setup.php');"
COMPOSER_TEST="if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
COMPOSER_UNLIK="unlink('composer-setup.php');"

URL_SQUELPRO="https://sequelpro.com/builds/Sequel-Pro-Build-97c1b85783.zip"
URL_ROBOTO3T="https://download-test.robomongo.org/mac/studio-3t-robo-3t-mac-double-pack.zip"
URL_FILEZILLA="https://dl3.cdn.filezilla-project.org/client/FileZilla_3.48.0_macosx-x86.app.tar.bz2?h=AuKI8bs0j49qNvXvwqV2eQ&x=1588789575"
URL_MOZILADEV="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=osx&lang=pt-BR"
URL_ENDPOIT_SECURIRY_VPN="http://dl3.checkpoint.com/paid/5a/5a79c5ab48ce58947a15852106dd2bcd/Endpoint_Security_VPN.dmg?HashKey=1588801235_6c7ed999658851e14493e525c43616b1&xtn=.dmg"
URL_UTORRENT_WEB="https://utweb-assets.bittorrent.com/installer/uTorrentWebInstaller.pkg"

FILE_MOZILADEV="FirefoxDevEdition.dmg"
FILE_FILEZILLA="FileZilla_3.48.0_macosx-x86.app.tar.bz2"
FILE_VPN_CAMARA="Endpoint_Security_VPN.dmg"

# Install XCode or Update
if ( ! xcodebuild -version ); then
  xcode-select --install;
else
  xcodebuild -version && echo "Comand line já instalado, use [Software Update] para instalar atualizações";
fi

# Install HomeBrew and update
/usr/bin/ruby -e "$(curl -fsSL $URL_HOMEBREW_INSTALLER)" && brew update;

# Install services
for service in ${DEV_SERVICES[*]}; do
  if ( ! brew list $service ); then
    brew isntall $service;
  else
    brew upgrade $service;
  fi
done

if ( brew list gnupg ); then
    curl -sSL $URL_RVMIO_IMPORT | gpg --import - && \curl -L $URL_RVMIO | bash -s stable;
    rvm get stable --autolibs=enable && gem update --system;
else
  echo "[RVM] precisa do gnupg - consulte no (brew list gnupg)";
fi

if ( ! brew list composer ); then
  php -r "$REPOSITORY_COMPOSER" && php -r "$COMPOSER_TEST";
  php composer-setup.php && php -r "$COMPOSER_UNLIK";
  sudo mv composer.phar /usr/local/bin/composer && echo "[Composer] - Instalado Manualmente";
else
  echo "[Composer] - já esta instalado!"
fi

# Install Apps in Brew
for app in ${APPS_BREW[*]}; do
  if ( ! brew cask list $app ); then
      brew cask isntall $app;
  else
    brew cask upgrade $app;
  fi
done

#Istall NVM
bash "$ROOT_DIR/node/nvm.sh";

if ( node --version ) && (npm -v); then
  bash "$ROOT_DIR/node/globals.sh"
else
  echo "Node não instalado verifique no nvm (nvm ls)."
fi

# configure nativescript
bash "$ROOT_DIR/nativescript_env.sh";

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
