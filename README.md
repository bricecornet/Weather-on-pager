# Weather-on-pager
Ce script Bash permet de récupérer la météo locale via l'API wttr.in et de l'envoyer vers un émetteur de pager (bipper) | This Bash script fetches local weather data from the wttr.in API and sends it to a pager (beeper)

Voici une proposition de fichier `README.md` clair et professionnel pour ton projet, structuré pour être prêt à l'emploi sur GitHub.

---

# 📟 Weather to Pager (POCSAG/Serial)

Ce script Bash permet de récupérer la météo locale via l'API `wttr.in` et de l'envoyer vers un émetteur de pager (bipper) via un port série (`/dev/ttyS0`). Il est conçu pour être exécuté automatiquement via `crontab`.

Le script nettoie strictement les données pour ne conserver que les chiffres et les unités de base, garantissant ainsi la compatibilité avec l'encodage ASCII limité (7 bits) des pagers.

## 🚀 Fonctionnalités

* **Extraction propre** : Supprime les couleurs ANSI, l'Unicode et les symboles spéciaux (°).
* **Format compact** : Idéal pour l'affichage sur une seule ligne (ex: `8 C 7 V 12 km/h P 0.0 mm`).
* **Sécurisé** : Gestion des timeouts réseau et vérification des droits sur le port série.

## 🛠️ Installation

1. **Cloner le script** ou copier le contenu de `meteo_pager.sh`.
2. **Rendre le script exécutable** :
```bash
chmod +x meteo_pager.sh

```


3. **Configuration** :
Ouvrez le fichier et modifiez les variables suivantes :
* `URL` : **Remplacez `verviers` par votre ville.**
* `CAPCODE` : Votre ID de pager (7 chiffres).
* `DEVICE` : Votre port série (ex: `/dev/ttyS0` ou `/dev/ttyUSB0`).


4. **Automatisation (Cron)** :
Pour un envoi à 7h et 19h tous les jours :
```bash
0 7,19 * * * /chemin/vers/votre/script/meteo_pager.sh >> /var/log/meteo_pager.log 2>&1

```



---

# 📟 Weather to Pager (POCSAG/Serial)

This Bash script fetches local weather data from the `wttr.in` API and sends it to a pager (beeper) transmitter via a serial port (`/dev/ttyS0`). It is designed for automated execution using `crontab`.

The script strictly cleans the data to keep only digits and basic units, ensuring 100% compatibility with the limited ASCII encoding (7-bit) used by most pagers.

## 🚀 Features

* **Strict Cleaning**: Removes ANSI colors, Unicode characters, and special symbols (like °).
* **Compact Format**: Optimized for single-line display (e.g., `8 C 7 V 12 km/h P 0.0 mm`).
* **Robust**: Handles network timeouts and checks serial port permissions.

## 🛠️ Setup

1. **Clone the script** or copy the content of `meteo_pager.sh`.
2. **Make it executable**:
```bash
chmod +x meteo_pager.sh

```


3. **Configuration**:
Open the file and update the following variables:
* `URL`: **Change `verviers` to your specific city name.**
* `CAPCODE`: Your pager ID (7 digits).
* `DEVICE`: Your serial port (e.g., `/dev/ttyS0` or `/dev/ttyUSB0`).


4. **Automation (Cron)**:
To send weather updates daily at 7 AM and 7 PM:
```bash
0 7,19 * * * /path/to/your/script/meteo_pager.sh >> /var/log/meteo_pager.log 2>&1

```

