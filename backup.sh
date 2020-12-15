#!/bin/bash

# =========================================================================== #
# user variables setup.
# feel free to adjust to your requirements

# --------------------------------------------------------------------------- #
# behaviour variables

REPOSITORY_NAME="PyScript"
FILE_PATTERNS="*.tex ./gfx Session.tks"

# --------------------------------------------------------------------------- #
# GIT setup

GITBASE="https://github.com"
USERNAME="TheBlueChameleon"


# =========================================================================== #
# Script variables. Change only if you know what you're doing

FLAG_SETMASTER="0"

# --------------------------------------------------------------------------- #
# Colour constants

COLOR_END="\033[m"
COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_BLUE="\033[0;34m"
COLOR_PURPLE="\033[0;35m"
COLOR_CYAN="\033[0;36m"
COLOR_GREY="\033[0;37m"
COLOR_LRED="\033[1;31m"
COLOR_LGREEN="\033[1;32m"
COLOR_LYELLOW="\033[1;33m"
COLOR_LBLUE="\033[1;34m"
COLOR_LPURPLE="\033[1;35m"
COLOR_LCYAN="\033[1;36m"
COLOR_LGREY="\033[1;37m"

# =========================================================================== #
#  Script

clear

if [ ! -d ./.git ]; then
  printf "About to create a git repository, named\n" 
  printf "   $COLOR_CYAN\'$REPOSITORY_NAME\'$COLOR_END\n"
  
  git init
  git remote add origin $GITBASE/$USERNAME/$REPOSITORY_NAME.git
  
  printf "Done.\n"
  
  FLAG_SETMASTER="1"
fi


git config credential.helper store
git config --global credential.helper 'cache --timeout 7200'

for FILE in $FILE_PATTERNS
do
  git add $FILE
done

git status


if [ "$FLAG_SETMASTER" = "1" ]; then
  printf "First time use of Backup. Automatically pushing with comment 'initial commit' to branch 'master'.\n"
  
  git commit -m "initial commit"
  git push --set-upstream origin master
  
  printf "done\n"
  
else
  printf "Ready for checkin. Please give a changelog comment:\n"
  read COMMITTEXT
  
  git commit -m "$COMMITTEXT"
  git push
fi

echo done
