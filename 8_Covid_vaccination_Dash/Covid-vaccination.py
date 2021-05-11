import pandas as pd
import numpy as np
import datetime
import plotly
import plotly.graph_objs as go
import warnings
warnings.filterwarnings("ignore")

locations = pd.read_csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/locations.csv", usecols=['location'])

locations_labels = locations['location']
locations_values = [nome.replace(' ', '%20') for nome in locations['location']]

import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_bootstrap_components as dbc
from dash.dependencies import Input, Output

app = dash.Dash(__name__, external_stylesheets = [dbc.themes.CYBORG],
                meta_tags=[{'name': 'viewport',
                             'content': 'width=device-width initial-scale=1.0'
                           } 
                          ]
               )

server = app.server

app.title = 'Número de pessoas vacinadas'

app.layout = dbc.Container([
        dbc.Row([
            dbc.Col([
                html.H2(children='Vaccine Dashboard - Data Science Recruit',
                        className='text-center shadow-lg',
                       )
            ],width = {'size':10, 'order':1 }),
            
            dbc.Col([
                dbc.Card(
                    dbc.CardBody([
                        dbc.CardLink("Website Link", href="https://datasciencerecruit.com/"),
                    ])
                )
            ],width = {'size':2, 'order':2 }),
        ]),
            
    html.Br(),
    
    html.P("Please select the amount of days that you wish to make predictions. Check 0 if you just want to check the current vaccination situation"),
    
    dcc.Dropdown(id='country',
                 options=[{'label':i, 'value':j} for i,j in zip(list(locations_labels), locations_values)],
                 multi=False,
                 value='Brazil'),
            
    dcc.Graph(id='graph', figure={})
    
])

# Connecta Plotly graphs com Dash Components
@app.callback(
    Output(component_id='graph', component_property='figure'),
    Input(component_id='country', component_property='value'),
)

def update_graph(country, days):
    file_path = 'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/country_data/{}.csv'.format(country)
    data = pd.read_csv(file_path, usecols=['date', 'total_vaccinations'])
    
    data['date'] = pd.to_datetime(data['date'])

    trace = go.Scatter(x=data['date'], y=data['total_vaccinations']),
    layout = go.Layout(title='Number of Vaccinated People - {}'.format(country.replace('%20', ' ')))
    fig = go.Figure(data=trace, layout=layout)
    
    return fig

if __name__ == '__main__':
    app.run_server(debug=True, port=8080, use_reloader=False)