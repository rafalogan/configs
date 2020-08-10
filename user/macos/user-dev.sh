#!/usr/bin/env zsh

# Scrkpits user dev enviroment
export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

# Constats
APP_DIRECTORY="$HOME/Downloads/programas"
URL_NVM_INSTALLER="https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh"

URL_HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/master/install"
URL_RVMIO_IMPORT="https://rvm.io/mpapis.asc"
URL_RVMIO_IMPORT2="https://rvm.io/pkuczynski.asc"
URL_RVMIO="https://get.rvm.io"

REPOSITORY_COMPOSER="copy('https://getcomposer.org/installer', 'composer-setup.php');"
COMPOSER_TEST="if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
COMPOSER_UNLIK="unlink('composer-setup.php');"

URL_SQUELPRO="https://sequelpro.com/builds/Sequel-Pro-Build-97c1b85783.zip"
URL_ROBOTO3T="https://download-test.robomongo.org/mac/studio-3t-robo-3t-mac-double-pack.zip"
URL_MOZILADEV="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=osx&lang=pt-BR"
URL_UTORRENT_WEB="https://utweb-assets.bittorrent.com/installer/uTorrentWebInstaller.pkg"
URL_FIRACODE="https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip"

FILE_MOZILADEV="FirefoxDevEdition.dmg"

# Arraes
DEV_SERVICES=(
  gnupg
  git
  composer
  wget
  nvm
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
  amazon-music
  zoomus
)

AUTOLOAD_NVMRC='# This loads nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# This Autoload nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$(nvm version default)" = "N/A" ]; then
    echo "Intall last node" &&
    nvm install node
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version" &&
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc';


PROFILES=(zshrc bashrc profile bash_profile)


# Install XCode or Update
if (! xcode-select -p ); then
  xcode-select --install &&
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
else
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
fi


# HomeBrew
if ( ! brew --version ); then
  # Install HomeBrew
  /usr/bin/ruby -e "$(curl -fsSL $URL_HOMEBREW_INSTALLER)" &&
  brew update &&
  brew Upgrade &&
  brew cask upgrade
else
  # Update Brew
  brew update &&
  brew Upgrade &&
  brew cask upgrade

fi

echo "Homebrew foi instalado ou atualizado,para que as modificações entrem em figor feche e abra o terminal novamente!" &&
clear



# Install service
for service in ${DEV_SERVICES[*]}; do
  if ( ! brew list $service ); then
    echo "Instalando o Serviço $service" &&
    brew install $service;
  else
    echo "Autualizando o Serviço $service" &&
    brew upgrade $service;
  fi
done

# Install Apps in Brew
for app in ${APPS_BREW[*]}; do
  if ( ! brew cask list $app ); then
    echo "Instalando APP $app" &&
      brew cask install $app;
  else
    echo "Atualizando APP $app" &&
    brew cask upgrade $app;
  fi
done

# Verify if gnupg is instaled and Istall rvm
if ( brew list gnupg ); then
    curl -sSL $URL_RVMIO_IMPORT | gpg --import - &&
    curl -sSL $URL_RVMIO_IMPORT2 | gpg --import - && \curl -L $URL_RVMIO | bash -s stable;
    rvm get stable --autolibs=enable && gem update --system;
else
  echo "[RVM] precisa do gnupg - consulte no (brew list gnupg)";
fi

# Verify if comoposer is isntaled
# and if no, use manual installer
if ( ! brew list composer ); then
  php -r "$REPOSITORY_COMPOSER" && php -r "$COMPOSER_TEST";
  php composer-setup.php && php -r "$COMPOSER_UNLIK";
  sudo mv composer.phar /usr/local/bin/composer && echo "[Composer] - Instalado Manualmente";
else
  echo "[Composer] - já esta instalado!"
fi

# Verify id NVM is instaled
# And if no, use manual installer
if ( ! nvm ); then
  echo "Qual tipo de instalação gostaria de unsar digite c[curl] ou w[wget]?" &&
  read installer
  if [ $installer = "w" ]; then
    wget -qO- $URL_NVM_INSTALLER | bash;
  else
    curl -o- $URL_NVM_INSTALLER | bash;
  fi
else
  echo "Atualizando NVM" &&
  brew update nvm
fi

# config nvm
if [ -d $NVM_BASE_DIR ]; then
  for profile in ${PROFILES[*]}; do
      if [ -f "$HOME/.$profile" ]; then
        echo "$AUTOLOAD_NVMRC" >> ~/.$profile && echo "[NVM Configurado] - .$profile";
      else
        echo "[$profile] - não encontrado";
      fi
  done
else
  echo "[FALHA] - diretorio $NVM_BASE_DIR não encontado!"
fi

# Ending
clear &&
echo "Instalações completas!"

# maker diretory
if [ ! -d "$APP_DIRECTORY" ]; then
  echo  "Criando diretorio" &&
  mkdir "$APP_DIRECTORY" &&
  echo "$APP_DIRECTORY - Criado com sucesso!"
else
  echo "[$APP_DIRECTORY] - Já existe";
fi

echo  "Iniciando Downloads!"

# Downloads Custom APPS
wget -c $URL_SQUELPRO -P "$APP_DIRECTORY";
wget -c $URL_ROBOTO3T -P "$APP_DIRECTORY";
wget -c $URL_UTORRENT_WEB -P "$APP_DIRECTORY";
wget -c $URL_FIRACODE -P "$APP_DIRECTORY";

wget -c $URL_MOZILADEV -O "$APP_DIRECTORY/$FILE_MOZILADEV";

# Ending
echo "User pré configurado com sucesso como ultimo passo instale os apps baixados e delete a ($APP_DIRECTORY)" &&
open $APP_DIRECTORY;