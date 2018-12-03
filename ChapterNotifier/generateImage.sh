#!/bin/bash
# Naipsas - Btc Sources
# This script downloads a program/app from a repository, prepares it
# and creates an image for it using its own dockerfile.
shopt -s extglob

# FUNCTIONS
function menu {

  echo "##########################"
  echo "######              ######"
  echo "# 1.- Generate Imgage    #"
  echo "# 2.- Deploy container   #"
  echo "# 3.- Exit               #"
  echo "######              ######"
  echo "##########################"

  echo ""
  echo -n "Select an option: "
  read Option

  case $Option in
    1 )
      GenerateImage
      ;;
    2 )
      DeployContainer
      ;;
    3 )
      clear
      exit
      ;;
    * )
      # Non valid option
      menu
      ;;

  esac

}

function backtoMenu()
{

  echo ""
	echo -n "Do you want to return to the menu? (Y/N) : "
  read Option

  if [ "$Option" = "Y" ] || [ "$Option" = "y" ]; then
    menu
  else
    exit
  fi

}

function GenerateImage()
{

  clear

  echo "Downloading Chapter Notifier repository...".
  BOTREADINESS=NO

  git clone https://github.com/Naipsas/TelegramBots.git &> /dev/null
  if [ "$?" -eq "0" ]; then

    echo -e "\tOK: repository downloaded!"
    echo "Cleaning unnecesary files..."

    cd ./TelegramBots
    rm -r !(ChapterNotifier)
    if [ "$?" -eq "0" ]; then
      echo -e "\tOK: unnecesary files deleted!"
    else
      echo -e "\tWARN: unnecesary files couldn't be deleted!"
    fi

    echo "Replacing Bot Token..."

    # Token extraction
    line=$(grep BotToken ./../PrivateData)
    read -ra splitted <<< "$line"
    actualToken=${splitted[1]}
    echo -e "\tToken: $actualToken"
    sed -i -e "s/BotFather_provided_token/$actualToken/g" "./ChapterNotifier/ChapterNotifier.py"
    cd ..

    if [ "$?" -eq "0" ]; then
      echo -e "\tOK: Bot Token replaced!"
      BOTREADINESS=YES
    else
      echo -e "\tERROR: We couldn't replace the Token!! Bot may not work!"
    fi

  else
    echo -e "\tWARN: We couldn't download the repository!"
  fi

  if [ "$BOTREADINESS" == "YES" ]; then

    echo "Generating Docker Image..."
    docker build -t chapternotifierimage . &> /dev/null
    if [ "$?" -eq "0" ]; then
      echo -e "\tOK: chapternotifierimage created!"
    else
      echo -e "\tCRITICAL: We couldn't create chapternotifierimage!"
    fi

  else
    echo "Finished, image cannot be created!"
  fi

  cd ..
  rm -rf ./TelegramBots

  backtoMenu

}

function DeployContainer()
{

  clear

  docker run chapternotifierimage

  backtoMenu

}

menu