import flask
import pickle
import pandas as pd
import psycopg2
import requests
from random import choice
from sklearn.preprocessing import StandardScaler

import sys
sys.path.insert(0, '..')
from Notebooks import config

# Use pickle to load in the pre-trained model and fitted scaler.
with open(f'model/titanic_model.pkl', 'rb') as f:
    model = pickle.load(f)

with open(f'model/titanic_scaler.pkl', 'rb') as s:
    scaler = pickle.load(s)

app = flask.Flask(__name__, template_folder='templates')


@app.route('/', methods=['GET', 'POST'])
def main():
    print(flask.request.method)
    get_passengers_url = flask.url_for('getpassengers', _external=True)
    random_passenger = requests.get(get_passengers_url).json()

    if flask.request.method == 'GET':
        return flask.render_template('main.html', random_passenger=random_passenger)

    if flask.request.method == 'POST':
        gender = flask.request.form['gender']
        age = flask.request.form['age']
        board_class = flask.request.form['board_class']
        embarked = flask.request.form['embarked']
        country = flask.request.form['country']

        # Use answers from input form to fill in values from hot encoding
        class_dict = {'class_1st': 0,
                      'class_2nd': 0,
                      'class_3rd': 0,
                      'class_crew': 0}
        embarked_dict = {'embarked_B': 0,
                         'embarked_C': 0,
                         'embarked_Q': 0,
                         'embarked_S': 0}
        country_dict = {'country_AFR': 0,
                        'country_ASA': 0,
                        'country_AUS': 0,
                        'country_ENG': 0,
                        'country_EUR': 0,
                        'country_FIN': 0,
                        'country_IRL': 0,
                        'country_LBN': 0,
                        'country_NAM': 0,
                        'country_SAM': 0,
                        'country_SWE': 0,
                        'country_USA': 0}
        # Figure out for loop that assigns value of 0 or 1
        # depending on what the form value is
        for key in list(class_dict):
            fullstring = key
            substring = board_class
            if substring in fullstring:
                class_dict[key] = 1
            else:
                class_dict[key] = 0

        for key in list(embarked_dict):
            fullstring = key
            substring = embarked
            if substring in fullstring:
                embarked_dict[key] = 1
            else:
                embarked_dict[key] = 0

        for key in list(country_dict):
            fullstring = key
            substring = country
            if substring in fullstring:
                country_dict[key] = 1
            else:
                country_dict[key] = 0

        # Create dataframe out of input variables.
        input_variables = pd.DataFrame([[gender,
                                         age,
                                         class_dict['class_1st'],
                                         class_dict['class_2nd'],
                                         class_dict['class_3rd'],
                                         class_dict['class_crew'],
                                         embarked_dict['embarked_B'],
                                         embarked_dict['embarked_C'],
                                         embarked_dict['embarked_Q'],
                                         embarked_dict['embarked_S'],
                                         country_dict['country_AFR'],
                                         country_dict['country_ASA'],
                                         country_dict['country_AUS'],
                                         country_dict['country_ENG'],
                                         country_dict['country_EUR'],
                                         country_dict['country_FIN'],
                                         country_dict['country_IRL'],
                                         country_dict['country_LBN'],
                                         country_dict['country_NAM'],
                                         country_dict['country_SAM'],
                                         country_dict['country_SWE'],
                                         country_dict['country_USA']]],
                                       columns=['gender',
                                                'age',
                                                'class_1st',
                                                'class_2nd',
                                                'class_3rd',
                                                'class_crew',
                                                'embarked_B',
                                                'embarked_C',
                                                'embarked_Q',
                                                'embarked_S',
                                                'country_AFR',
                                                'country_ASA',
                                                'country_AUS',
                                                'country_ENG',
                                                'country_EUR',
                                                'country_FIN',
                                                'country_IRL',
                                                'country_LBN',
                                                'country_NAM',
                                                'country_SAM',
                                                'country_SWE',
                                                'country_USA'],
                                       dtype=float)
        # Input data frame into model to predict values
        # Use fitted scaler to transform input
        input_variables_scaled = scaler.transform(input_variables)

        prediction = model.predict(input_variables_scaled)[0]

        if prediction == 1:
            outcome = 'You survived!'
        else:
            outcome = 'You did not survive :('

        return flask.render_template('main.html',
                                     original_input={'Gender': gender,
                                                     'Age': age,
                                                     'Boarding Class': board_class,
                                                     'Embarked': embarked,
                                                     'Country': country
                                                     },
                                     result=str(outcome),
                                     random_passenger=random_passenger
                                     )

##################################################################################

# Establish database connection (requires config.py file with database password)
def get_db_connection():
    conn = psycopg2.connect(host='localhost',
                            database='titanic_project',
                            user='postgres',
                            password=config.db_password)
    return conn

# API route that gets all passengers from database
@app.route('/api/getpassenger')
def getpassengers():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('select * from passenger_registry;')
    passengers = cur.fetchall()
    cur.close()
    conn.close()

##################################################################################

# Format random passenger before converting to JSON for browser
    random_passenger=list(choice(passengers))
    if random_passenger[4]=='C':
        random_passenger[4]='Cherbourg, France'
    if random_passenger[4]=='S':
        random_passenger[4]='Southampton, England'
    if random_passenger[4]=='Q':
        random_passenger[4]='Queenstown, Ireland'
    if random_passenger[4]=='B':
        random_passenger[4]='Belfast, Ireland'
    
    if random_passenger[6] is None:
        random_passenger[6] ='N/A'
    else: 
        random_passenger[6]="{:,.0f}". format(random_passenger[6])
    
    if random_passenger[7] is None:
        random_passenger[7] ='N/A'
    else: 
        random_passenger[7]="£{:,.2f}". format(random_passenger[7])

    if random_passenger[10]=='no':
        random_passenger[10]='../static/images/smallRedX.png'
    if random_passenger[10]=='yes':
        random_passenger[10]='../static/images/smallGreenCheck.png'

    return flask.jsonify(random_passenger)

##################################################################################

if __name__ == '__main__':
    app.run()
