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

while true; do
    # Affichage du menu
    echo "                +------------+"
    echo "                |   Menu :   |"
    echo "       +--------+------------+----------+"
    echo "       |         Installation           |       "
    echo "+------+--------------------------------+------+"
    echo "|  1. Installer docker                         |"
    echo "|  2. Installer yarn                           |"
    echo "+----------------------------------------------+"
    echo ""
    echo "                +-------------+"
    echo "                |    Script : |"
    echo "  +-------------+------------ +--------------+"
    echo "  | 3. Exécuter 'new.sh'                     |"
    echo "  |                                          |"
    echo "  | 4. Exécuter 'speedtest.sh'               |"
    echo "  |                                          |"
    echo "  | 5. Exécuter 'massgrave.cmd'              |"
    echo "  +---------------------------+--------------+"
    echo "                | 6. Quitter |"
    echo "                +------------+"


    # Lecture du choix de l'utilisateur
    read -p "Choisissez une option (1-6) : " choix

    # Traitement du choix
    case $choix in
        
        1)
            echo "Installation de Pterodactyl."
            # Ajoutez le code correspondant à l'Option 1 ici
            bash <(curl -s https://raw.githubusercontent.com/LucieFairePy/Pterodactyl-Installer-FR/main/install.sh)
            ;;
        2)
            echo "Installation du thème Stellar v3.3."
            # Ajoutez le code correspondant à l'Option 2 ici
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/main/.assets/initialisation.sh)
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/main/.assets/theme_stellar.sh)
            ;;
        3)
            echo "Installation du thème Enigma v3.9."
            # Ajoutez le code correspondant à l'Option 3 ici
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/main/.assets/initialisation.sh)
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/main/.assets/theme_enigma.sh)
            ;;
        4)
            echo "Installation du thème Billing Module"
            # Ajoutez le code correspondant à l'Option 4 ici
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/main/.assets/theme_billing.sh)
            ;;
        5)
            echo "Installation du thème Billing Module"
            # Ajoutez le code correspondant à l'Option 4 ici
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/main/.assets/theme_billing.sh)
            ;;
        6)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Choix non valide. Veuillez entrer un numéro entre 1 et 5."
            ;;
    esac
done