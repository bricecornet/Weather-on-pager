#!/bin/bash

# ==========================================
# Script d'envoi Météo vers Pager (POCSAG)
# Version : Fix Températures (Mode Texte Pur)
# ==========================================

# 1. Récupération de la météo
# On ajoute "T" à la fin (ex: /verviers_T.png ou /verviers?T) 
# pour forcer le mode "No-Color" de l'API.
URL="wttr.in/verviers?T&format=%t_%f_%w_%p"

# On récupère la donnée brute
RAW_WEATHER=$(curl -s -m 10 "$URL")

# Nettoyage manuel des caractères de contrôle restants (juste au cas où)
RAW_WEATHER=$(echo "$RAW_WEATHER" | tr -d '\r\n')

# Traduction du signe moins mathématique Unicode en tiret clavier
RAW_WEATHER=${RAW_WEATHER//−/-}

# Vérification en cas de panne réseau
if [ -z "$RAW_WEATHER" ] || [[ "$RAW_WEATHER" == *"Unknown"* ]] || [[ "$RAW_WEATHER" == *"<"* ]]; then
    MESSAGE="Err Meteo"
else
    # On sépare les données via le délimiteur "_"
    # On utilise 'cut' ici, c'est parfois plus fiable que 'read' sur certaines versions de Bash
    RAW_T=$(echo "$RAW_WEATHER" | cut -d'_' -f1)
    RAW_F=$(echo "$RAW_WEATHER" | cut -d'_' -f2)
    RAW_W=$(echo "$RAW_WEATHER" | cut -d'_' -f3)
    RAW_P=$(echo "$RAW_WEATHER" | cut -d'_' -f4)

    # EXTRACTION STRICTE DES CHIFFRES
    # On garde : les chiffres, le point, et le signe MOINS (le vrai du clavier)
    T_VAL=$(echo "$RAW_T" | tr -dc '0-9-')
    F_VAL=$(echo "$RAW_F" | tr -dc '0-9-')
    W_VAL=$(echo "$RAW_W" | tr -dc '0-9')
    P_VAL=$(echo "$RAW_P" | tr -dc '0-9.')

    # Si la température est positive, tr ne garde pas le '+'. 
    # On peut le rajouter manuellement si nécessaire, ou laisser juste le chiffre.
    # Ici on reconstruit le message proprement.
    MESSAGE="${T_VAL} C ${F_VAL} V ${W_VAL} km/h P ${P_VAL} mm"
fi

# 2. Configuration du matériel
DEVICE="/dev/ttyS0"
BAUD=9600
CAPCODE="1234567"

if [ ! -w "$DEVICE" ]; then
    echo "Erreur Droits Device" >&2
    exit 1
fi

stty -F "$DEVICE" $BAUD cs8 -cstopb -parenb -ixon -ixoff

# 3. Envoi
printf "\x19R%s\x8A%s\x18" "$CAPCODE" "$MESSAGE" > "$DEVICE"

echo "$(date) - Envoyé : $MESSAGE"
