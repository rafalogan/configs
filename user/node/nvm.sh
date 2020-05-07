#!/usr/bin/env zsh

# To use commad nvm
export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

# Cosntats
URL_NVM_INSTALLER="https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh";
NVM_BASE_DIR="$HOME/.nvm";

AUTOLOAD_NVMRC='# This loads nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

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
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc';

PROFILES=(zshrc bashrc profile bash_profile);


#verifica se existe instalações anteriores
if [ -d $NVM_BASE_DIR ]; then
  echo "Já exite uma versão anterior do NVM!";
  echo "A nova instalação irar apagar todas instalações anteriores deseja continuar (s/n)?n"
  read proximo

  if [ $proximo = "s" ] || [ $proximo = "S" ]; then
    echo "Continuando..."
  else
    exit;
  fi
fi

#Message For installer reader
echo "Qual tipo de instalação gostaria de unsar digite c[curl] ou w[wget]?c"
read installer

if [ $installer = "c" ]; then
    curl -o- $URL_NVM_INSTALLER | bash;
elif [ $installer = "w" ]; then
    wget -qO- $URL_NVM_INSTALLER | bash;
else
    curl -o- $URL_NVM_INSTALLER | bash;
fi


# configurando nvm
if [ -d $NVM_BASE_DIR ]; then
  for profile in ${PROFILES[*]}; do
      if [ -f "$HOME/.$profile" ]; then
        echo "$AUTOLOAD_NVMRC" >> ~/.$profile && echo "[NVM Configurado] - .$profile";
      else
        echo "[$profile] - não encontrado";
      fi
  done

  if ( ! nvm --version); then
      touch "$HOME/.bash_profile" && echo "$AUTOLOAD_NVMRC" >> $HOME/.bash_profile;
       echo "[.bash_profile Criadao] - [NVM Configurado]";
  else
    echo "NVM - configurando corretamente!"
  fi
else
  echo "[FALHA] - diretorio $NVM_BASE_DIR não encontado!"
fi

# teste final
if ( nvm --help ); then
    echo "NVM - instalado com sucesso!" && nvm i node;
else
  echo "[ERRO] - NVN não foi instalado corretamente"
fi
