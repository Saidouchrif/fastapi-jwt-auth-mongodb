@echo off
echo ========================================
echo   FastAPI JWT Auth MongoDB - Docker
echo ========================================
echo.

echo [1/3] Arret des conteneurs existants...
docker-compose down

echo.
echo [2/3] Construction des images...
docker-compose build

echo.
echo [3/3] Demarrage des services...
docker-compose up -d

echo.
echo ========================================
echo   Services demarres!
echo ========================================
echo.
echo Frontend:  http://localhost:5173
echo Backend:   http://localhost:8000
echo API Docs:  http://localhost:8000/docs
echo MongoDB:   localhost:27017
echo.
echo Pour voir les logs:
echo   docker-compose logs -f
echo.
echo Pour arreter:
echo   docker-compose down
echo.
pause

