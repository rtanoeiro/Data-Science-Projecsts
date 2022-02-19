import pandas as pd
import numpy as np
from datetime import date
import plotly.graph_objs as go
import warnings
warnings.filterwarnings("ignore")

full_data = pd.read_csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv",
                        usecols=['continent', 'location', 'date', 'total_cases', 'total_deaths', 'total_vaccinations',
                                 'people_vaccinated', 'people_fully_vaccinated', 'population',

                                 'population_density', 'aged_65_older', 'gdp_per_capita'])

locations_labels = full_data['location'].unique()
locations_values = [name.replace(' ', '%20') for name in locations_labels]

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
app.title = 'COVID DASHBOARD'

server = app.server

app.layout = dbc.Container([
    dbc.Row([
        dbc.Col([
            html.H2(children='COVID Dashboard - Data Science Recruit',
                    className='text-center shadow-lg',
                    )
        ], width={'size': 10, 'order': 1}),

        dbc.Col([
            dbc.Card(
                dbc.CardBody([
                    dbc.CardLink("Website Link", href="https://datasciencerecruit.com/"),
                ])
            )
        ], width={'size': 2, 'order': 2}),
    ]),

    html.Br(),

    html.H4("Please select the country that you wish to check current situation", className='text-center'),

    html.Br(),

    dcc.Dropdown(id='country',
                 options=[{'label': i, 'value': j} for i, j in zip(list(locations_labels), locations_values)],
                 multi=False,
                 value='Brazil'),
    html.Br(),

    dcc.Tabs(id='tabs-example', value='tab-1', children=[
        dcc.Tab(label='Vaccination', value='tab-1', children=[
            html.Br(),

            dbc.Row([
                dbc.Col([
                    html.H5("Please select the start date you want the graph to begin", className="text-center")
                ], width={'size': 9, 'order': 1}),

                dbc.Col([
                    dcc.DatePickerSingle(id='date_selector',
                                         min_date_allowed=date(2020, 8, 1),
                                         max_date_allowed=date.today(),
                                         initial_visible_month=date(2020, 10, 1),
                                         date=date(2020, 10, 1),
                                         className='text-center',
                                         )
                ], width={'size': 3, 'order': 2})
            ]),

            html.H5(id='percentage_vaccination', children={}, className='text-center shadow-lg'),

            dcc.Graph(id='vaccine_graph', figure={}),

            html.Br(),
        ]),

        dcc.Tab(label='Cases and Deaths', value='tab-2', children=[
            dbc.Row([
                dbc.Col([
                    html.Br(),
                    html.H6(id='cases_text', children={}, className='text-center shadow-lg'),
                    html.Br(),
                    dcc.Graph(id='cases_graph', figure={})
                ], width={'size': 6, 'order': 1}),

                dbc.Col([
                    html.Br(),
                    html.H6(id='deaths_text', children={}, className='text-center shadow-lg'),
                    html.Br(),
                    dcc.Graph(id='deaths_graph', figure={})
                ], width={'size': 6, 'order': 2}),
            ])
        ]),
    ]),
])

# Connects Plotly graphs with Dash Components
@app.callback(
    Output(component_id='percentage_vaccination', component_property='children'),
    Output(component_id='vaccine_graph', component_property='figure'),
    Output(component_id='cases_text', component_property='children'),
    Output(component_id='cases_graph', component_property='figure'),
    Output(component_id='deaths_text', component_property='children'),
    Output(component_id='deaths_graph', component_property='figure'),
    Input(component_id='country', component_property='value'),
    Input(component_id='date_selector', component_property='date')
)
def update_graph(country, start_date):
    ## ---------------------------------- Vaccination -------------------------------------- ##

    country_data = full_data.loc[full_data['location'] == country.replace('%20', ' ')]
    country_data['date'] = pd.to_datetime(country_data['date'])

    start_date = pd.to_datetime(start_date)
    end_date = country_data['date'].tail(1).values[0]

    country_data = country_data.loc[(country_data['date'] >= start_date) & (country_data['date'] <= end_date)]

    trace1 = [
        go.Scatter(x=country_data['date'],
                   y=country_data['people_vaccinated'],
                   name='1st dose', mode='markers'),

        go.Scatter(x=country_data['date'],
                   y=country_data['people_fully_vaccinated'],
                   name='Fully vaccinated', mode='markers'),

        go.Scatter(x=country_data['date'],
                   y=country_data['total_vaccinations'],
                   name='Total Vaccinations',
                   line_color='#00cc44', mode='markers')

    ]

    layout1 = go.Layout(title='Number of Vaccinated People - {}'.format(country.replace('%20', ' ')))
    fig1 = go.Figure(data=trace1, layout=layout1)

    population = float(country_data.tail(1)['population'].values)

    i = 1

    while np.isnan(country_data.tail(i)['people_vaccinated'].values[0]) == True:
        i = i + 1
        if i == 50:
            break

    j = 1

    if i == 50:
        while np.isnan(country_data.tail(j)['total_vaccinations'].values[0]) == True:
            j = j + 1
            if j == 50:
                break

    if i < 50:
        people_vaccinated = country_data.tail(i)['people_vaccinated'].values[0]
        percentage1 = float(np.round((people_vaccinated / population) * 100, 2))
        text1 = '{}% of all persons with at least 1 dose in {}'.format(percentage1, country.replace('%20', ' '))
    elif (i == 50) & (j < 50):
        people_vaccinated = country_data.tail(j)['total_vaccinations'].values[0]
        percentage1 = float(np.round((people_vaccinated / population) * 100, 2))
        text1 = 'A total of {} vaccination doses where applied in {} - Total population: {}'.format(people_vaccinated,
                                                                                                    country.replace(
                                                                                                        '%20', ' '),
                                                                                                    population)
    elif (j == 50) & (j == 50):
        text1 = 'There is no  vaccination data for the last 50 days on'.format(country.replace('%20', ' '))

        ## ---------------------------------- Cases -------------------------------------- ##

    cases_deaths_data = full_data[['date', 'total_cases', 'total_deaths']].loc[
        full_data['location'] == country.replace('%20', ' ')]
    cases_deaths_data['date'] = pd.to_datetime(cases_deaths_data['date'])
    trace2 = [
        go.Scatter(x=cases_deaths_data['date'],
                   y=cases_deaths_data['total_cases'],
                   name='Cases',
                   line_color='#660066')
    ]

    layout2 = go.Layout(title='Number of Cases - {}'.format(country.replace('%20', ' ')))

    cases_deaths_data = full_data[['date', 'total_cases', 'total_deaths']].loc[
        full_data['location'] == country.replace('%20', ' ')]
    cases_deaths_data['date'] = pd.to_datetime(cases_deaths_data['date'])

    i = 1

    while np.isnan(cases_deaths_data.tail(i)['total_cases'].values[0]) == True:
        i = i + 1
        if i == 50:
            break

    j = 1

    if i == 50:
        while np.isnan(cases_deaths_data.tail(j)['total_deaths'].values[0]) == True:
            j = j + 1
            if j == 50:
                break

    if (i < 50) & (j < 50):
        total_cases = cases_deaths_data.tail(i)['total_cases'].values[0]
        total_deaths = cases_deaths_data.tail(i)['total_deaths'].values[0]
        percentage2 = float(np.round((total_cases / population) * 100, 2))
        percentage3 = float(np.round((total_deaths / population) * 100, 2))
        text2 = 'There is a total of {}% of persons infected by COVID in {}'.format(percentage2,
                                                                                    country.replace('%20', ' '))
        text3 = '{}% of all population died due to COVID in {}'.format(percentage3, country.replace('%20', ' '))
    elif (i == 50) & (j < 50):
        total_deaths = cases_deaths_data.tail(j)['total_deaths'].values[0]
        percentage3 = float(np.round((total_deaths / population) * 100, 2))
        text2 = 'There is no recent data for confirmed cases in the last 50 days'
        text3 = '{}% of all population died due to COVID in {}'.format(percentage3, country.replace('%20', ' '))
    elif (j == 50) & (j == 50):
        text2 = 'There is no recent data for confirmed cases in the last 50 days'
        text3 = 'There is no recent data for confirmed deaths in the last 50 days'

    fig2 = go.Figure(data=trace2, layout=layout2)

    ## ---------------------------------- Deaths -------------------------------------- ##

    trace3 = [
        go.Scatter(x=cases_deaths_data['date'],
                   y=cases_deaths_data['total_deaths'],
                   name='Deaths',
                   line_color='#000000'
                   )
    ]

    layout3 = go.Layout(title='Number of Deaths - {}'.format(country.replace('%20', ' ')))

    fig3 = go.Figure(data=trace3, layout=layout3)

    return text1, fig1, text2, fig2, text3, fig3

if __name__ == '__main__':
    app.run_server(debug=True, port=8080, use_reloader=False)