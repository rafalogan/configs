#!/usr/bin/env zsh
# Variables
ROOT_DIR=$(pwd);

URL_RVMIO_IMPORT="https://rvm.io/mpapis.asc"
URL_RVMIO="https://get.rvm.io"

REPOSITORY_COMPOSER="copy('https://getcomposer.org/installer', 'composer-setup.php');"
COMPOSER_TEST="if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
COMPOSER_UNLIK="unlink('composer-setup.php');"

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

# Execute
brew update &&
# Install services
for service in ${DEV_SERVICES[*]}; do
  if ( ! brew list $service ); then
    brew install $service;
  else
    brew upgrade $service;
  fi
done
# Install Apps in Brew
for app in ${APPS_BREW[*]}; do
  if ( ! brew cask list $app ); then
      brew cask install $app;
  else
    brew cask upgrade $app;
  fi
done
# Verify if gnupg is instaled and Istall rvm
if ( brew list gnupg ); then
    curl -sSL $URL_RVMIO_IMPORT | gpg --import - && \curl -L $URL_RVMIO | bash -s stable;
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
# Ending
echo "Instalações completas!"
