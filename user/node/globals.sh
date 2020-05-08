#!/usr/bin/env zsh
# Variables
# To use commad nvm
export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

GULP="gulp-cli"
TYPESCRIPT="typescript"
ANGULAR="@angular/cli"
REACTAPP="create-react-app"
VUE="@vue/cli"
NATIVESCIRPT="nativescript"

DIRECT_PLUGINS=(
  pm2
  knex
  http-server
)

# Install or update plugins
for plugin in ${DIRECT_PLUGINS[*]}; do
  if ( ! $plugin --version ); then
    echo "Instalando - $plugin" && sudo npm i -g $plugin;
  else
    echo "Atualizando - $plugin" && sudo npm up -g $plugin;
  fi
done
# Install or update Gulp
if ( ! gulp --version ); then
    echo "Instalando - $GULP" && sudo npm i -g $GULP;
else
  echo "Atualizando - $GULP" && sudo npm up -g $GULP;
fi
# Install or update Typescript
if ( ! tsc --version ); then
    echo "Instalando - $TYPESCRIPT" && sudo npm i -g $TYPESCRIPT;
else
  echo "Atualizando - $TYPESCRIPT" && sudo npm up -g $TYPESCRIPT;
fi
# Install or update Angular/cli
if ( ! ng --versino ); then
  echo "Instalando - $ANGULAR" && sudo npm i -g $ANGULAR;
else
  echo "Atualizando - $ANGULAR" && sudo npm up -g $ANGULAR;
fi
# Install vue
if ( ! vue --version ); then
  echo "Instalando - $VUE" && sudo npm i -g $VUE;
else
  echo "Atualizando - $VUE" && sudo npm up -g $VUE;
fi
#Install Nativescript
if ( ! tns --version ); then
  echo "Instalando - $NATIVESCIRPT" && sudo npm i -g $NATIVESCIRPT;
else
  echo "Atualizando - $NATIVESCIRPT" && sudo npm up -g $NATIVESCIRPT;
fi
# Ending
echo "Instalação finalizada com sucesso!"
