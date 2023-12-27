#!/bin/bash

# Définir les couleurs
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
VIOLET=$(tput setaf 5)
BOLD=$(tput bold)
RESET=$(tput sgr0)
########################################## INITIALISATION ROOT ##########################################

# Vérifier si l'utilisateur est root
if [[ $EUID -ne 0 ]]; then
   echo "${RED}${BOLD}Ce script doit être exécuté en tant que root${RESET}" 
   # Demander le mot de passe
   sudo "$0" "$@"
   exit 1
fi

# Le reste du script ici

######################################### DOWNLOAD & EXTRACT ############################################

### DOSSIER TEMPORAIRE ###

# Définir le chemin du dossier à vérifier
dossier="/tmp/pterodactylthemeinstaller"

# Vérifier si le dossier existe
if [ -d "$dossier" ]; then
    # Vérifier si le dossier est vide
    if [ -z "$(ls -A $dossier)" ]; then
        echo "${BOLD}Le dossier existe mais est vide.${RESET}"
    else
        # Supprimer le contenu du dossier s'il n'est pas vide
        rm -r "$dossier"/*
        echo "${RED}${BOLD}Le contenu du dossier a été supprimé avec succès.${RESET}"
    fi
else
    # Créer le dossier s'il n'existe pas
    mkdir -p "$dossier"
    echo "${GREEN}${BOLD}Le dossier a été créé avec succès.${RESET}"
fi

### DOWNLOAD ###

cd /tmp/pterodactylthemeinstaller
echo ""
echo "${BOLD}Téléchargement du thème :${RESET}"
echo ""
wget -O enigma-v39.zip https://files.catbox.moe/lqxk6x.zip

### EXTRACT SELECTED FILE ###

echo ""
echo "${BOLD}Extraction du thème...${RESET}"

unzip enigma-v39.zip >/dev/null 2>&1
echo "${BOLD}Déplacement du thème...${RESET}"
rsync -a --remove-source-files app net resources public tailwind.config.js /var/www/pterodactyl
echo ""

########################################## BUILD ########################################################

cd /var/www/pterodactyl

## Installation cross-env
echo "${BOLD}Installation de 'cross-env' via yarn...${RESET}"
yarn add cross-env >/dev/null 2>&1

## NPX Installation
echo "${BOLD}Mise à jour de NPX...${RESET}"
npx update-browserslist-db@latest >/dev/null 2>&1

### APPLIQUER ###

echo "${BOLD}Application du thème...${RESET}"
cd /var/www/pterodactyl && php artisan view:clear >/dev/null 2>&1 && php artisan config:clear >/dev/null 2>&1 && chown -R www-data:www-data /var/www/pterodactyl/* 

### BUILD ###

echo "${VIOLET}${BOLD}Re-build du thème en cour...${RESET}"
yarn build:production >/dev/null 2>&1
echo "${GREEN}${BOLD}Build Terminé !.${RESET}"
echo ""