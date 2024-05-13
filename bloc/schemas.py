from pydantic import BaseModel
from typing import List, Optional

class Artist(BaseModel):
    name: str
    genre: str

class MusicEventBase(BaseModel):
    id: int
    informasi_acara: dict
    daftar_artis: List[Artist]
    tiket_dan_harga: List[dict]
    fasilitas_dan_layanan: dict
    informasi_tambahan: dict
    ulasan_dan_rating: dict
    galeri_foto_dan_video: dict

class MusicEventCreate(BaseModel):
    informasi_acara: dict
    daftar_artis: List[Artist]
    tiket_dan_harga: List[dict]
    fasilitas_dan_layanan: dict
    informasi_tambahan: dict
    ulasan_dan_rating: dict
    galeri_foto_dan_video: dict

class MusicEvent(MusicEventBase):
    class Config:
        orm_mode = True
