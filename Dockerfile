# Étape 1 : Utiliser une image de base pour construire l'application Angular
FROM node:18 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers nécessaires
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application pour la production
RUN npm run build -- --output-path=dist/app

# Étape 2 : Utiliser une image NGINX pour servir l'application
FROM nginx:alpine

# Copier les fichiers de build Angular vers le dossier par défaut de NGINX
COPY --from=build /app/dist/app /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Démarrer NGINX
CMD ["nginx", "-g", "daemon off;"]
