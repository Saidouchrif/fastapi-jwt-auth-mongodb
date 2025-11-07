from fastapi import FastAPI
from app.auth.routes import router as auth_router

app = FastAPI(title="FastAPI JWT Auth MongoDB")

app.include_router(auth_router)

@app.get("/")
def home():
    return {"message": "API Auth FastAPI + MongoDB + JWT 👋"}
