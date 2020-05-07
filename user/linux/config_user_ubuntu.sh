#!/usr/bin/env zsh

# Constats
# Repositories to add
PPA_LIBRATBAG="ppa:libratbag-piper/piper-libratbag-git"
PPA_LUTRIS="ppa:lutris-team/lutris"
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_CYBERMAX="ppa:cybermax-dexter/sdl2-backport"
PPA_ORACLE_JAVA="ppa:webupd8team/java"
PPA_NUMIX_CIRCLE_ICON="ppa:numix/ppa"

#Url's to downloads
URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"
URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.20.40428-bionic_amd64.deb"
URL_WHATSAPP="https://www.thefanclub.co.za/sites/all/modules/pubdlcnt/pubdlcnt.php?file=https://www.thefanclub.co.za/sites/default/files/public/downloads/whatsapp-webapp_1.0_all.deb&nid=200"

URL_MYSQLWORKBENCH_20="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.20-1ubuntu20.04_amd64.deb"
URL_MYSQLWORKBENCH_18="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.20-1ubuntu18.04_amd64.deb"
URL_VSCODE="https://go.microsoft.com/fwlink/?LinkID=760868"

URL_FLETREMIX="https://github.com/daniruiz/flat-remix"
URL_FLETREMIX_GTK="https://github.com/daniruiz/flat-remix-gtk"

#Directories
DOWNLOAD_DIRECTORY="$HOME/Downloads/programas"
THEME_DIRECTORY="$HOME/Downloads/temas"
SYSTEM_VERSION=$(lsb_release -sd | cut -c 8-)

#Applications to install
BASIC_APPS=(
  ubuntu-restricted-extras
  ratbagd
  piper
  lutris
  winehq-stable
  banshee
  gparted
  synaptic
  fontconfig
  imagemagick
  software-properties-common
  git
  oracle-java8-installer
  oracle-java14-installer
  tilix
  zsh
  gnome-tweaks-tool
  arc-theme
  adwaita-icon-theme-full
  numix-gtk-theme
  numix-icon-theme
  numix-icon-theme-circle
  numix-icon-theme-square
  gnome-shell-extensions
  libvulkan1
  libvulkan1:i386
  libgnutls30:i386
  libldap-2.4-2:i386
  libgpg-error0:i386
  libxml2:i386
  libasound2-plugins:i386
  libsdl2-2.0-0:i386
  libfreetype6:i386
  libdbus-1-3:i386
  libsqlite3-0:i386
)

BASIC_SNAP_APPS=(
  spotify
  vlc
  skype
  photogimp
  opera
)

DEV_APPS=(
  build-essential
  filezilla
  atom
  defalt-jdk
  libssl-dev
  exuberant-ctags
  ncurses-term
  ack-grep
  silversearcher-ag
  libmagickwand-dev
  vim-gtk3
  curl
  docker.io
)

DEV_APPS_SNAP=(
  code
  atom
  slack
  gitkraken
  postman
  zoom-client
  rocketchat-desktop
  discord
)

CUSTOM_APPS=(
  default-jre
  openjdk-8-jre-headless
  openssh-server
)


# refresh SuperUser password
echo "Deseja tocar a senha do super usuário 'sudo (s/n)? n"
read super_user;

if [ $super_user = "s" ] || [ $super_user = "S" ]; then
    echo "Primeiro digite a senha do usuário do computador \n
    em segudida sera solicitada a nova senha e a confirmação da nova senha \n
    use o [entre] para confimar cada etapa" && sudo passwd;
fi

# Update of system
echo "Se você trocou a senha no passo anterior user a nova senha,
caso contrario user a senha co computador";

sudo apt update -y && sudo apt list --upgradeable -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y;

# Add extrenals repositories
# Wine Repositories
sudo dpkg --add-architecture i386;
wget -qO - $URL_WINE_KEY | sudo apt-key add -;

if [ $SYSTEM_VERSION = "18.04.4 LTS" ]; then
  sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y;
  sudo add-apt-repository $PPA_CYBERMAX -y;
else
  sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main' -y;
fi

sudo apt-add-repository $PPA_LIBRATBAG -y;
sudo add-apt-repository $PPA_LUTRIS -y;
sudo apt-add-repository $PPA_GRAPHICS_DRIVERS -y;
sudo add-apt-repository $PPA_ORACLE_JAVA -y;
sudo add-apt-repository $PPA_NUMIX_CIRCLE_ICON;

sudo apt update -y;

# install basic applicatios
for app in ${BASIC_APPS[*]}; do
    if ( ! dpkg -l | grep -q $app); then
      if [ $app = "winehq-stable" ]; then
        sudo apt install --install-recommends $app -y && echo "Instalação do $app concluida com sucesso!";
      else
        sudo apt install $app -y && echo "Instalação do $app concluida com sucesso!";
      fi
    else
      echo "[Instalado] - $app"
    fi
done

if ( ! wine --version ); then
    sudo apt install aptitude -y && sudo apt install winehq-stable;
fi

# install snaps
for snapapp in ${BASIC_SNAP_APPS[*]}; do
    if [ $snapapp = "skype" ]; then
      sudo snap install $snapapp --classic;
    else
      sudo snap install $snapapp;
    fi
done

# Install applications external
if [ ! -d $DOWNLOAD_DIRECTORY ]; then
    mkdir "$DOWNLOAD_DIRECTORY" && echo "[Pasta Programas - criada]"
fi

wget -c $URL_GOOGLE_CHROME -P $DOWNLOAD_DIRECTORY;
wget -c $URL_SIMPLE_NOTE -P $DOWNLOAD_DIRECTORY;
wget -c $URL_4K_VIDEO_DOWNLOADER -P $DOWNLOAD_DIRECTORY;
wget -c $URL_INSYNC -P $DOWNLOAD_DIRECTORY;
wget -c $URL_WHATSAPP -P $DOWNLOAD_DIRECTORY;

sudo dpkg -i $DOWNLOAD_DIRECTORY/*.deb -y;

#Install Development enviroment
echo "Deseja instalar os pacotes basicos para desenvolvimento s/n?n"
read devuser

if [ $deveuser = "s" ] || [ $devuser = "S" ]; then
    #Update repositories
    sudo apt update -y && sudo apt list --upgradeable && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y;

    # Install Dev Apps
    for app in ${DEV_APPS[*]}; do
      if ( ! dpkg -l | grep -q $app ); then
        sudo apt install &app && echo "Instalação do $app concluida com sucesso!";
      else
        echo "[Instalado] - $app"
      fi
    done

    #Download external apps
    if [ ! -d $DOWNLOAD_DIRECTORY ]; then
      mkdir "$DOWNLOAD_DIRECTORY" && echo "[Pasta Programas - criada]";
    fi

    if [ $SYSTEM_VERSION = "18.04.4 LTS" ]; then
      wget -c $URL_MYSQLWORKBENCH_18 -P $DOWNLOAD_DIRECTORY;
    else
      wget -c $URL_MYSQLWORKBENCH_20 -P $DOWNLOAD_DIRECTORY;
    fi

    wget -c $URL_VSCODE -P $DOWNLOAD_DIRECTORY;

    sudo dpkg -i $DOWNLOAD_DIRECTORY/*.deb

    #Istall snaps
    echo  "Deseja instalar a IDE PHPStorm, é uma IDE de licença paga\n
    para mais informações consulte https://www.jetbrains.com/pt-br/phpstorm/buy/#commercial?billing=yearly \n
    se tiver interesse ou se ja tiver a licença prossiga s/n? n"
    read byide

    if [ $byide = "s" ] || [ $byide = "S" ] && ( ! dpg -l | gerp phpstorm ); then
        sudo snap install phpstorm --classic;
    fi

    for snapapp in ${DEV_APPS_SNAP[*]}; do
        if [ $snapapp = "slack" ] || [ $snapapp = "code"] || [ $snapapp = "atom" ]; then
            sudo snap install $snapapp --classic;
        else
            sudo snap install $snapapp;
        fi
    done
fi

# custum apps istaller
echo  "Aqui tem alguns aplicativos opcionais deseja instal-los s/n? n"
read customapp

if [ $customapp = "s" ] || [ $customapp = "S" ]; then
  #Update repositories
  sudo apt update -y && sudo apt list --upgradeable && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y;

  # Install Dev Apps
  for app in ${CUSTOM_APPS[*]}; do
    if ( ! dpkg -l | grep -q $app ); then
      sudo apt install &app && echo "Instalação do $app concluida com sucesso!";
    else
      echo "[Instalado] - $app"
    fi
  done
fi


# Install Flat-remix-theme
if [ ! -d "$THEME_DIRECTORY" ]; then
  mkdir "$THEME_DIRECTORY" && cd $THEME_DIRECTORY;
else
 cd $THEME_DIRECTORY;
fi

git clone $URL_FLETREMIX;
git clone $URL_FLETREMIX_URL_FLETREMIX_GTK;

mkdir -p $HOME/.icons && mkdir -p $HOME/.themes;
cp -r flat-remix/Flat-Remix* $HOME/.icons/ && cp -r flat-remix-gtk/Flat-Remix-GTK* $HOME/.themes/;

cd;

# Remove Drirectories
echo "Deseja remover os diretórios criados na pasta Downloads s/n? n"
read distroy_dir

if [ $distroy_dir = "s" ] || [ $distroy_dir = "S" ]; then
    rm -rf $DOWNLOAD_DIRECTORY && echo "Diretório [Programas] removido com sucesso!";
    rm -rf $THEME_DIRECTORY && echo "Driretório [Temas] removido com sucesso!";
fi

# End, update and clinner
sudo apt update && sudo apt dist-upgrade -y;
flatpak update;
sudo apt autoclean;
sudo apt autoremove -y

sudo reboot -y;
