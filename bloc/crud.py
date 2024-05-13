from typing import List, Optional
from schemas import MusicEvent, MusicEventCreate
import json

# Load data from JSON file
def load_data():
    with open("data.json", "r") as file:
        return json.load(file)

def write_data(data):
    with open("data.json", "w") as file:
        json.dump(data, file, indent=4)

data = load_data()

def get_music_events():
    return data["acara_musik"]

def get_music_event(acara_id: int):
    for acara in data["acara_musik"]:
        if acara["id"] == acara_id:
            return acara
    return None

def create_music_event(acara: MusicEventCreate):
    acara_dict = acara.dict()
    data["acara_musik"].append(acara_dict)
    write_data(data)
    return acara_dict

def update_music_event(acara_id: int, acara: MusicEventCreate):
    for idx, item in enumerate(data["acara_musik"]):
        if item["id"] == acara_id:
            data["acara_musik"][idx] = acara.dict()
            write_data(data)
            return acara.dict()
    return None

def delete_music_event(acara_id: int):
    for idx, item in enumerate(data["acara_musik"]):
        if item["id"] == acara_id:
            del data["acara_musik"][idx]
            write_data(data)
            return True
    return False
