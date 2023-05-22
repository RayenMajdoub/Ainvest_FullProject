from flask import Flask, jsonify, request
from geopy.geocoders import Nominatim
from geopy.distance import distance
import requests

app = Flask(__name__)

@app.route('/get_location_data', methods=['POST'])
def get_location_data():
    values = request.get_json()
    adresse = values.get('adresse')
    geolocator = Nominatim(user_agent="geoapiExercises")
    location = geolocator.geocode(adresse)
    if location is None:
        return jsonify({'error': 'Adresse invalide'})
    else:
        lat = location.latitude
        lon = location.longitude
        url = "https://nominatim.openstreetmap.org/search"
        params = {
            "format": "json",
            "addressdetails": 1,
            "limit": 5,
            "dedupe": 1,
            "q": "école",
            "lat": lat,
            "lon": lon,
        }
        response = requests.get(url, params=params)
        schools = response.json()
        schools_data = []
        for school in schools:
            name = school["display_name"]
            dist = distance((lat, lon), (float(school["lat"]), float(school["lon"])))
            schools_data.append({'name': name, 'distance': round(dist.km, 2)})
        params["q"] = "hôpital"
        response = requests.get(url, params=params)
        hospitals = response.json()
        hospitals_data = []
        for hospital in hospitals:
            name = hospital["display_name"]
            dist = distance((lat, lon), (float(hospital["lat"]), float(hospital["lon"])))
            hospitals_data.append({'name': name, 'distance': round(dist.km, 2)})
        return jsonify({'schools': schools_data, 'hospitals': hospitals_data})

if __name__ == '__main__':
    app.run(debug=True, port=5002)