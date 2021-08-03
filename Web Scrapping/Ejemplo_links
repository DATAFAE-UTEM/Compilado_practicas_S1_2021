# Importaciones
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import pandas as pd
import csv

# Set opciones Chrome
chrome_options = Options()
chrome_options.add_argument("--incognito")
chrome_options.add_argument("--window-size=1920x1080")

# Google Chrome
driver = webdriver.Chrome(options=chrome_options,
                          executable_path="C:\\Program Files (x86)\\chromedriver.exe")

def link(url):
    # Navegacion
    driver.get(url)

    # Data
    data = {}
    df = pd.DataFrame(columns=['Links'])

    # Definicion de elementos
    ids = driver.find_elements_by_css_selector('.mime_doc') #Definición de elemento para descarga

    for ii in ids:
        # definicion de referencia, dentro del elemento definidio
        data['Links'] = ii.get_attribute('href')
        df = df.append(data, ignore_index=True)
        print(df)
    # creacion de .csv
    df.to_csv('Resoluciones_cursadas_links')

# Insertar link a scrapear
link('https://www.cmfchile.cl/institucional/resoluciones/resoluciones_cursadas_meses_anteriores.php')
