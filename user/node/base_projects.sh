#!/bin/zsh
#!/bin/bash
# Script to create files basase of the projects Node.js
DEFAULT_CREATED="has created with success!"
NODE_VERSION=$(node --version)

echo $NODE_VERSION > .nvmrc
echo ".nvmrc $DEFAULT_CREATED"

echo "#Idea's
\.idea
\.vscode

#Files
.DS_Store
.env

#Foldes
dist
build
**/dbase

#Modules
node_modules
vendor " > .gitignore;
echo ".gitignore $DEFAULT_CREATED"

echo "root = true

[*]
charset = utf-8
indent_style = tab
indent_size = 2
insert_final_newline = true
trim_trailing_whitespace = true
ij_typescript_force_quote_style = true
ij_typescript_use_double_quotes = false

[*.md]
max_line_length = off
trim_trailing_whitespace = false" > .editorconfig;
echo ".editorconfig $DEFAULT_CREATED"
