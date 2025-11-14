# 🔧 Guide de Dépannage Docker

## Problèmes Courants et Solutions

### 1. Le backend ne démarre pas

#### Vérifier les logs
```bash
docker-compose logs backend
```

#### Problèmes courants :
- **Erreur : ModuleNotFoundError** → Les fichiers `__init__.py` manquent
  - ✅ **Solution** : Les fichiers `__init__.py` ont été ajoutés dans `app/`, `app/models/`, et `app/auth/`

- **Erreur : MONGO_URI not set** → Variable d'environnement manquante
  - ✅ **Solution** : La variable `MONGO_URI` est maintenant définie dans `docker-compose.yml`

- **Erreur : SECRET_KEY not set** → Variable d'environnement manquante
  - ✅ **Solution** : La variable `SECRET_KEY` est maintenant définie dans `docker-compose.yml`

### 2. MongoDB ne démarre pas

#### Vérifier les logs
```bash
docker-compose logs mongodb
```

#### Vérifier le healthcheck
```bash
docker-compose ps
```

Le statut de MongoDB doit être "healthy" avant que le backend ne démarre.

### 3. Le backend ne peut pas se connecter à MongoDB

#### Vérifier la connexion
```bash
# Entrer dans le conteneur backend
docker-compose exec backend bash

# Tester la connexion MongoDB
python -c "from motor.motor_asyncio import AsyncIOMotorClient; import asyncio; client = AsyncIOMotorClient('mongodb://mongodb:27017/fastapi_auth'); print('Connected!')"
```

#### Vérifier le réseau Docker
```bash
docker network inspect fastapi-jwt-auth-mongodb_app-network
```

### 4. Reconstruire les conteneurs

Si vous avez modifié les fichiers Docker ou les dépendances :

```bash
# Arrêter tous les conteneurs
docker-compose down

# Reconstruire sans cache
docker-compose build --no-cache

# Redémarrer
docker-compose up -d
```

### 5. Nettoyer complètement

Si rien ne fonctionne, nettoyez tout :

```bash
# Arrêter et supprimer les conteneurs
docker-compose down -v

# Supprimer les images
docker-compose down --rmi all

# Nettoyer le système Docker (attention : supprime tout)
docker system prune -a --volumes

# Reconstruire depuis zéro
docker-compose up --build
```

### 6. Vérifier les ports

Assurez-vous que les ports ne sont pas déjà utilisés :

```bash
# Windows PowerShell
netstat -ano | findstr :8000
netstat -ano | findstr :5173
netstat -ano | findstr :27017

# Linux/Mac
lsof -i :8000
lsof -i :5173
lsof -i :27017
```

### 7. Vérifier les permissions (Linux/Mac)

Si vous avez des problèmes de permissions :

```bash
# Donner les permissions d'écriture
sudo chown -R $USER:$USER ./backend
sudo chown -R $USER:$USER ./frontend
```

### 8. Commandes de diagnostic

```bash
# Voir tous les conteneurs
docker-compose ps

# Voir les logs en temps réel
docker-compose logs -f

# Voir les logs d'un service spécifique
docker-compose logs -f backend

# Vérifier les variables d'environnement
docker-compose exec backend env | grep MONGO
docker-compose exec backend env | grep SECRET

# Tester la connexion au backend
curl http://localhost:8000

# Tester l'endpoint de santé
curl http://localhost:8000/
```

### 9. Problèmes spécifiques Windows

#### WSL2 requis
Docker Desktop sur Windows nécessite WSL2. Vérifiez :
```bash
wsl --status
```

#### Problèmes de chemins
Si vous avez des problèmes avec les chemins Windows, utilisez des chemins relatifs dans `docker-compose.yml`.

### 10. Vérifier la version de Docker

Assurez-vous d'avoir une version récente :
```bash
docker --version
docker-compose --version
```

Minimum requis :
- Docker 20.10+
- Docker Compose 2.0+

## Checklist de Vérification

Avant de signaler un problème, vérifiez :

- [ ] Docker et Docker Compose sont installés et à jour
- [ ] Les ports 8000, 5173, et 27017 sont libres
- [ ] Les fichiers `__init__.py` existent dans tous les packages
- [ ] Le fichier `requirements.txt` est présent dans `backend/`
- [ ] Le fichier `package.json` est présent dans `frontend/`
- [ ] Les variables d'environnement sont définies dans `docker-compose.yml`
- [ ] MongoDB est "healthy" avant que le backend ne démarre
- [ ] Les logs ne montrent pas d'erreurs critiques

## Obtenir de l'aide

Si le problème persiste :

1. Collectez les logs complets :
   ```bash
   docker-compose logs > docker-logs.txt
   ```

2. Vérifiez la configuration :
   ```bash
   docker-compose config
   ```

3. Vérifiez l'état des conteneurs :
   ```bash
   docker-compose ps -a
   ```

