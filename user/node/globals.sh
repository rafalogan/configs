#!/usr/bin/env zsh

INSTALL_NODE=(
  nativescript
  @angular/cli
  typescript
  gulp-cli
  http-server
  create-react-app
  @vue/cli
  pm2
  knex
);

#global install
for component in ${INSTALL_NODE[*]}; do
    if ! $component --version; then
      npm i -g $component && echo "[Instalado] - $component";
    else
      npm up -g $component && echo "[Atualizado] - $component";
    fi
done
