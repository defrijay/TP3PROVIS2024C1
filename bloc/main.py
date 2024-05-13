from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import json

app = FastAPI()

# Middleware untuk menangani CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["*"],
)

class Acara(BaseModel):
    id: int
    informasi_acara: dict
    daftar_artis: List[dict]
    tiket_dan_harga: List[dict]
    fasilitas_dan_layanan: dict
    informasi_tambahan: dict
    ulasan_dan_rating: dict
    galeri_foto_dan_video: dict

# Load data from JSON file
def load_data():
    with open("data/pentas_seni.json", "r") as file:
        return json.load(file)

def write_data(data):
    with open("data/pentas_seni.json", "w") as file:
        json.dump(data, file, indent=4)

data = load_data()

@app.post("/acara/")
async def create_acara(acara: Acara):
    data["acara_musik"].append(acara.dict())
    write_data(data)
    return acara

@app.get("/acara/")
async def get_acara():
    return data["acara_musik"]

@app.get("/acara/{acara_id}")
async def get_single_acara(acara_id: int):
    for acara in data["acara_musik"]:
        if acara["id"] == acara_id:
            return acara
    raise HTTPException(status_code=404, detail="Item not found")

@app.put("/acara/{acara_id}")
async def update_acara(acara_id: int, acara: Acara):
    for idx, item in enumerate(data["acara_musik"]):
        if item["id"] == acara_id:
            data["acara_musik"][idx] = acara.dict()
            write_data(data)
            return {"message": "Acara updated successfully"}
    raise HTTPException(status_code=404, detail="Item not found")

@app.patch("/acara/{acara_id}")
async def partial_update_acara(acara_id: int, acara: Acara):
    for idx, item in enumerate(data["acara_musik"]):
        if item["id"] == acara_id:
            data["acara_musik"][idx].update(acara.dict(exclude_unset=True))
            write_data(data)
            return {"message": "Acara updated successfully"}
    raise HTTPException(status_code=404, detail="Item not found")

@app.delete("/acara/{acara_id}")
async def delete_acara(acara_id: int):
    for idx, item in enumerate(data["acara_musik"]):
        if item["id"] == acara_id:
            del data["acara_musik"][idx]
            write_data(data)
            return {"message": "Acara deleted successfully"}
    raise HTTPException(status_code=404, detail="Item not found")
