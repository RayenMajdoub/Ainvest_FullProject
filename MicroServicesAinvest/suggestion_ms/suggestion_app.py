import joblib
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import StandardScaler
modelAppartement = joblib.load('./Ml_models/estimationApp.pkl')
modelMaison = joblib.load('./Ml_models/estimationMaison.pkl')
from flask import Flask, request ,jsonify
from flask_cors import CORS

app = Flask(__name__)
cors = CORS(app)
cors = CORS(app, resources={r"/*": {"origins": "*"}})

@app.route('/SuggApp', methods=['POST'])
def predict():
        values = request.get_json()
        print(values)
        # Create a dictionary to hold the values
        data = {
            'Date mutation': values.get('Date mutation'),
            'Nature mutation': values.get('Nature mutation'),
            'Type de voie': values.get('Type de voie'),
            'Voie': values.get('Voie'),
            'Code postal': values.get('Code postal'),
            'Commune': values.get(    'Commune'),
            'Code departement': values.get(   'Code departement'),
            'Section': values.get( 'Section'),
            'Type local': values.get( 'Type local'),
            'Surface reelle bati': values.get('Surface reelle bati'),
            'Nombre pieces principales': values.get('Nombre pieces principales'),
            'Nature culture': values.get( 'Nature culture'),
            'Prix_par_metre_carre': values.get( 'Prix_par_metre_carre'),
            'Valeur fonciere': values.get('Valeur fonciere')
        }
        # Create a DataFrame from the dictionary
        reqData = pd.DataFrame(data, index=[0])
        print(reqData)
        if reqData['Type local'][0] == "Maison":       
            feature = ['Surface reelle bati', 'Nombre pieces principales']
            target = 'Valeur fonciere'
            X = reqData[feature].values.reshape(-1,1)
            y = reqData[target]
            scaler = StandardScaler()
            X = scaler.fit_transform(X)
            prediction = modelMaison.predict(X)
            response_data = {"predicted_value": prediction[0]}
            response = jsonify(response_data)
            response.status_code = 200
            print(response)
            return response
        else:
            feature = 'Surface reelle bati'
            target = 'Valeur fonciere'
            X = reqData[feature].values.reshape(-1,1)
            y = reqData[target]
            scaler = StandardScaler()
            X = scaler.fit_transform(X)
            prediction = modelAppartement.predict(X)
            response_data = {"predicted_value": prediction[0]}
            response = jsonify(response_data)
            response.status_code = 200
            print(response)
            return response

if __name__ == '__main__':
    app.run(host='localhost', port=5051)