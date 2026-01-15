from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Iteration 1: allow all origins (simple). Tighten later.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/predict")
def predict():
    # ML logic later. For now, just a stub to prove comms.
    return {"message": "Hello from FastAPI container!"}
