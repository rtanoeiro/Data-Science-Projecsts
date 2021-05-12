import pandas as pd
import requests
import arrow

data_tibau = pd.read_csv("data_tibau.csv", names=['time', 'velocity', 'direction'])

start = list(data_tibau['time'])[-1]

start = arrow.get(start)
end = start.shift(days=1)

lat, lng = -6.168371, -35.096696  # Tibau
lat1, lng1 = -6.419553, -34.976585  # Baia_Formosa

parameters = ['windSpeed20m', 'windDirection20m']

print(data_tibau)