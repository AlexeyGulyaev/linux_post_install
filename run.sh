#!/bin/bash
echo 'проверка файлов в дериктории'
# файл можго взять отсюда https://www.google.ru/intl/ru/chrome/
file_google=google-chrome-stable_current_amd64.deb
# файл можго взять отсюда https://desktop.telegram.org/
file_telegramm=tsetup.2.5.6.beta.tar.xz
# файл можго взять отсюда https://www.jetbrains.com/ru-ru/pycharm/download/#section=linux
file_pycharm=pycharm-community-2020.3.3.tar.gz
# файл можго взять отсюда https://dbeaver.io/download/?start&os=linux&arch=x86_64&dist=deb
file_dbeaver=dbeaver-ce_7.3.3_amd64.deb
# файл можго взять отсюда 
file_zoom=zoom_amd64.deb # в скрипте пока не прописан
if [ -f $file_google ] && [ -f $file_telegramm ] && [ -f $file_pycharm ] && [ -f $file_dbeaver ] && [ -f$file_zoom]; then
echo 'всё ок =) погнали!'
echo 'установка базовых программ'
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y xz-utils
sudo apt install curl -y
echo 'установка системного монитора'
sudo apt install -y htop
echo 'установка хрома'
sudo dpkg -i google-chrome-stable_current_amd64.deb
echo 'установка telegram'
mkdir ~/Apps
tar -xf tsetup.2.5.6.beta.tar.xz -C ~/Apps
echo 'установка python'
sudo apt install -y python3
sudo apt install -y virtualenv
sudo apt install -y python3-pip
echo 'install sublime'
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update -y
sudo apt-get install sublime-text  -y
echo 'установка git'
sudo apt install git -y
echo 'установка docker'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -ag docker $USER
newgrp docker
echo 'установка docker-compose'
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo 'установка pycharm community'
tar -xf pycharm-community-2020.3.3.tar.gz -C ~/Apps
sudo ln -s ~/Apps/pycharm-community-2020.3.3/bin/pycharm.sh /usr/local/bin/charm
echo 'установка postgres'
sudo apt install libpq-dev
sudo apt install -y postgresql postgresql-contrib
sudo sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
echo 'установка dbeaver'
sudo dpkg -i dbeaver-ce_7.3.3_amd64.deb
echo 'Установка Skype'
wget -q -O - https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
sudo sudo sh -c 'echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype-stable.list'
sudo apt update && sudo apt install skypeforlinux -y
echo 'Установка Zoom'
sudo dpkg -i zoom_amd64.deb
sudo apt update -y
sudo apt upgrade -y
echo 'Установка TimeShift для резерного копирования системы, на ubuntu его обычно нету'
sudo apt-add-repository -y ppa:teejee2008/ppa
sudo apt update
sudo apt install timeshift
echo 'последние штрихи'
sudo apt update -y
sudo apt upgrade -y
# восстановление зависимостей
sudo apt install -y -f
# удаление лишних пакетов, чистка кеша APT
sudo apt autoremove -y
sudo apt-get autoclean -y
echo 'все выполнено, поздравляю! =)'
echo 'и пройдитесь по логу на всякий случай, вдруг где-то что-то не поставилось'
echo 'и да прибудет с вами сила!'
else
echo 'проверьте файлы! возможно некоторые отсутствуют или имеют другое имя'
fi
