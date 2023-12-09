#!/bin/bash
#This script will configure the SML backup system

echo  " "
echo  " ##############################################################"
echo  " #            SML Backup coonfiguration  Script               #"
echo  " #            Developed by sergio melas 2011-23               #"
echo  " #                                                            #"
echo  " #                Emai: sergiomelas@gmail.com                 #"
echo  " #                   Released unde GPV V2.0                   #"
echo  " #                                                            #"
echo  " ##############################################################"
echo  " "


VAR=$0
DIR="$(dirname "${VAR}")"
cd  "${DIR}"


echo  "Configure lauchers"

#Exec='<path>/.autorun' %U
command="Exec='"${DIR}"/.autorun' %U"
file="'"${DIR}"/Backup.desktop'"
command="echo \""$command" \">>  "$file
eval $command

#Exec='<path>/.autodelete' %U
command="Exec='"${DIR}"/.autodelete' %U"
file="'"${DIR}"/Delete.desktop'"
command="echo \""$command" \">>  "$file
eval $command

#Icon=<path>/.icon/backup.png
command="Icon="${DIR}"/.icon/backup.png"
file="'"${DIR}"/Backup.desktop'"
command="echo \""$command" \">>  "$file
eval $command

#Icon=<path>/.icon/shredder.png
command="Icon="${DIR}"/.icon/shredder.png"
file="'"${DIR}"/Delete.desktop'"
command="echo \""$command" \">>  "$file
eval $command

#delete myself
command="rm '"${DIR}"/install.sh'"
eval $command

echo  "Login as administrator to install nedded packages"
sudo ls >/dev/null
echo  ""
sudo apt-get install  zenity rsync original-awk
