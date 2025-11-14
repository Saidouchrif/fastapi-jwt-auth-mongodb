# Guide Docker pour FastAPI JWT Auth MongoDB

Ce guide explique comment exécuter le projet avec Docker.

## Prérequis

- Docker installé
- Docker Compose installé

## Démarrage rapide

1. **Construire et démarrer tous les services :**
   ```bash
   docker-compose up --build
   ```

2. **Démarrer en arrière-plan :**
   ```bash
   docker-compose up -d --build
   ```

3. **Arrêter les services :**
   ```bash
   docker-compose down
   ```

4. **Arrêter et supprimer les volumes (données MongoDB) :**
   ```bash
   docker-compose down -v
   ```

## Services

- **Frontend** : http://localhost:5173
- **Backend API** : http://localhost:8000
- **MongoDB** : localhost:27017

## Commandes utiles

- **Voir les logs :**
  ```bash
  docker-compose logs -f
  ```

- **Voir les logs d'un service spécifique :**
  ```bash
  docker-compose logs -f backend
  docker-compose logs -f frontend
  docker-compose logs -f mongodb
  ```

- **Redémarrer un service :**
  ```bash
  docker-compose restart backend
  ```

- **Reconstruire un service :**
  ```bash
  docker-compose up --build backend
  ```

## Configuration

Le fichier `docker-compose.yml` configure :
- MongoDB avec persistance des données
- Backend FastAPI avec hot-reload (volumes)
- Frontend React/Vite avec hot-reload (volumes)
- Réseau Docker pour la communication entre services

## Variables d'environnement

Le backend utilise la variable `MONGO_URI` qui est automatiquement configurée dans `docker-compose.yml` pour pointer vers le service MongoDB.

Pour le frontend, la variable `VITE_API_URL` est définie dans `docker-compose.yml` pour pointer vers le backend.

