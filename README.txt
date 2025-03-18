# Température Alert - Yii2 Weather Notification (EN)

This web application allows users to check the temperature of a chosen city and automatically sends an email alert when the average temperature of the last 3 days falls below the Belgian regulation threshold for changing tires.

## Features
- **City Temperature Search**: Allows the user to search for the current temperature of any city.
- **Historical Temperature Calculation**: Calculates the average temperature for the past 3 days.
- **Email Notification**: Automatically sends an email alert when the average temperature falls below the Belgian regulation threshold (for example, below 7°C) for changing tires.

## How it Works
1. The user inputs the name of a city in the search bar.
2. The application fetches the current and historical temperature data (last 3 days) from a weather API (e.g., OpenWeatherMap).
3. It calculates the average temperature for the last 3 days.
4. If the average temperature is lower than the required threshold (according to Belgian regulations), the app sends an email notification to the user to remind them to change their tires.

## Technologies Used
- **Yii2 Framework**: A high-performance PHP framework for developing modern web applications.
- **Weather API**: Used to fetch the temperature data for the selected city. Note: You need to provide your own OpenWeatherMap API key for the application to fetch temperature data.
- **Yii2 Mailer**: Used for sending the email notifications to the user when the temperature is below the regulation threshold.

# Pneu hiver - Notification Météo Yii2 (FR)
Cette application web permet aux utilisateurs de consulter la température d'une ville choisie et envoie automatiquement une alerte par e-mail lorsque la température moyenne des 3 derniers jours est inférieure au seuil réglementaire belge pour le changement de pneus.

# Fonctionnalités
- Recherche de température par ville : Permet à l'utilisateur de rechercher la température actuelle de n'importe quelle ville.
- Calcul de la température historique : Calcule la température moyenne des 3 derniers jours.
- Notification par email : Envoie automatiquement une alerte par e-mail lorsque la température moyenne est inférieure au seuil réglementaire belge (par exemple, en dessous de 7°C) pour changer de pneus.

# Fonctionnement
- L'utilisateur entre le nom d'une ville dans la barre de recherche.
- L'application récupère les données de température actuelles et historiques (des 3 derniers jours) via une API météo (par exemple, OpenWeatherMap).
- Elle calcule la température moyenne des 3 derniers jours.
- Si la température moyenne est inférieure au seuil requis (selon les réglementations belges), l'application envoie une notification par e-mail à l'utilisateur pour lui rappeler de changer ses pneus.

# Technologies utilisées
- Framework Yii2 : Un framework PHP performant pour le développement d'applications web modernes.
- API Météo : Utilisée pour récupérer les données de température de la ville choisie. Remarque : Vous devez fournir votre propre clé API OpenWeatherMap pour que l'application puisse récupérer les données de température.
- Yii2 Mailer : Utilisé pour envoyer des notifications par e-mail à l'utilisateur lorsque la température est inférieure au seuil réglementaire.