#Utilise une image Node.js comme image de base
FROM node:18 as build-stage

#Définit le répertoire de travail dans le conteneur
WORKDIR /app

#Copie les fichiers package.json et package-lock.json pour installer les dépendances
COPY package*.json ./

#Installe les dépendances
RUN npm install

#Copie tous les fichiers du projet dans le conteneur
COPY . .

#Compile et construit l'application Vue.js pour la production
RUN npm run build

#Utilise une image Nginx pour servir l'application
FROM nginx:stable-alpine as production-stage

#Copie les fichiers de build de l'étape précédente dans le répertoire par défaut de Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

#Expose le port sur lequel Nginx sert l'application
EXPOSE 80

#Lance Nginx
CMD ["nginx", "-g", "daemon off;"]