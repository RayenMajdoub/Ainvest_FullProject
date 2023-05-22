import json
from typing import Self
import numpy as np
import pandas as pd
from flask import Flask, jsonify, request 
from flask_cors import CORS
from pymongo import MongoClient
import seaborn as sns
from datetime import datetime
from bson.objectid import ObjectId

# ...import asyncio
app = Flask(__name__)
CORS(app)
client = MongoClient('localhost', 27017)
db = client['ainvest']
collection = db['biens']
def FormateData(data):
    try:
        if data:
            return jsonify({"data": data})
        else:
            raise ValueError("Data not found!")
    except Exception as e:
        raise ValueError(f"Invalid data: {e}")

@app.route('/searchBien', methods=["GET"])
async def search_bien():
    try:
        queryparam = request.args.to_dict()
        query = {}
        print(queryparam)
        if "Date mutation" in queryparam:
            date = datetime.fromisoformat(queryparam["Date mutation"])
            year = date.year
            month = date.month
            query["$expr"] = {
                "$and": [
                    {"$eq": [{"$year": "$Date mutation"}, year]},
                    {"$eq": [{"$month": "$Date mutation"}, month]},
                ],
            }

        if "Nature mutation" in queryparam:
            query["Nature mutation"] = queryparam["Nature mutation"]

        if "Valeur fonciere max" in queryparam and "Valeur fonciere min" in queryparam:
            value_min = int(queryparam["Valeur fonciere min"])
            value_max = int(queryparam["Valeur fonciere max"])
            query["Valeur fonciere"] = {"$gte": value_min, "$lte": value_max}
        elif "Valeur fonciere max" in queryparam:
            value = int(queryparam["Valeur fonciere max"])
            query["Valeur fonciere"] = {"$lte": value}
        elif "Valeur fonciere min" in queryparam:
            value = int(queryparam["Valeur fonciere min"])
            query["Valeur fonciere"] = {"$gte": value}

        if "Type de voie" in queryparam:
            query["Type de voie"] = queryparam["Type de voie"]

        if "Voie" in queryparam:
            query["Voie"] = queryparam["Voie"]

        if "Code postal" in queryparam:
            code_postal = int(queryparam["Code postal"])
            query["Code postal"] = code_postal

        if "Commune" in queryparam:
            query["Commune"] = queryparam["Commune"]

        if "Code departement" in queryparam:
            code_dept = int(queryparam["Code departement"])
            query["Code departement"] = code_dept

        if "Code commune" in queryparam:
            code_commune = int(queryparam["Code commune"])
            query["Code commune"] = code_commune

        if "Section" in queryparam:
            query["Section"] = queryparam["Section"]

        if "No plan" in queryparam:
            no_plan = int(queryparam["No plan"])
            query["No plan"] = no_plan

        if "Nombre de lots" in queryparam:
            nb_lots = int(queryparam["Nombre de lots"])
            query["Nombre de lots"] = nb_lots

        if "Type local" in queryparam:
            query["Type local"] = queryparam["Type local"]

        if "Surface min" in queryparam and "Surface max" in queryparam:
            surface_min = int(queryparam["Surface min"])
            surface_max = int(queryparam["Surface max"])
            query["Surface reelle bati"] = {"$gte": surface_min, "$lte": surface_max}
        elif "Surface min" in queryparam:
            surface = int(queryparam["Surface min"])
            query["Surface reelle bati"] = {"$gte": surface}
        elif "Surface max" in queryparam:
            surface = int(queryparam["Surface max"])
            query["Surface reelle bati"] = {"$lte": surface}

        if "Nombre pieces principales" in queryparam:
            nb_pieces = int(queryparam["Nombre pieces principales"])
            print(nb_pieces)
            query["Nombre pieces principales"] = nb_pieces

        if "Nature culture" in queryparam:
            query["Nature culture"] = queryparam["Nature culture"]

        if "Surface terrain min" in queryparam and "Surface terrain max" in queryparam:
            surface_min = int(queryparam["Surface terrain min"])
            surface_max = int(queryparam["Surface terrain max"])
            query["Surface terrain"] = {"$gte": surface_min, "$lte": surface_max}
        elif "Surface terrain min" in queryparam:
            surface = int(queryparam["Surface terrain min"])
            query["Surface terrain"] = {"$gte": surface}
        elif "Surface terrain max" in queryparam:
            surface = int(queryparam["Surface terrain max"])
            query["Surface terrain"] = {"$lte": surface}
        result = collection.find(query)
        print(result)
        dataset = pd.DataFrame(result)
     #   print(results_list)
        #Statistique nbr de peice battons
        countplot = sns.countplot(x="Nombre pieces principales", data=dataset)
        x_data = [float(tick.get_text()) for tick in countplot.get_xticklabels()]
        y_data = [patch.get_height() for patch in countplot.patches]
        max_x = max(x_data)
        max_y = max(y_data)

        #statistique range de prix  camembert
        ranges = [(0, 250000), (250000, 500000), (500000, 750000), (750000, 1000000), (1000000, np.inf)]
        total_rows = len(dataset)
        percentages = {}
    
        most_frequent_type_local = dataset["Type local"].mode()[0]
        moyen_prix = dataset["Valeur fonciere"].mean() / 100

        for r in ranges:
            count = len(dataset[(dataset['Valeur fonciere'] >= r[0]) & (dataset['Valeur fonciere'] < r[1])])
            percentage = round(count / total_rows * 100, 2)
            label = '{}k-{}k'.format(r[0] // 1000, r[1] // 1000)
            percentages[label] = percentage

        data_result = {
            'axe_x': x_data,
            'axe_y': y_data,
            'max_x': max_x,
            'max_y': max_y,
            'percentages': percentages,
            'nbr_transaction': total_rows,
            'moyen_prix': moyen_prix,
            "type_local": most_frequent_type_local
        }
        print(data_result)
        response =  FormateData(data_result)
        return response
    except Exception as e:
        return str(e)

if __name__ == '__main__':
    app.run(debug=True, port=5000)