# Importaciones
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import pandas as pd

# Set de opciones para Chrome
chrome_options = Options()
chrome_options.add_argument("--incognito")
chrome_options.add_argument("--window-size=1920x1080")

driver = webdriver.Chrome(options=chrome_options,
                          executable_path="C:\\Program Files (x86)\\chromedriver.exe")


# Funcio definida para extraer data de esta pagina.
# se creo esta funcion con el fin de facilitar la extraccion de tablas adicionales que poseen la misma estructura.
def get_data(url):
    # Navegacion
    driver.get(url)
    print(driver.title)

    # Estructura de data
    data = {}
    df1 = pd.DataFrame(columns=['Fecha', 'N.Documento', 'Entidad', 'Materia']) #Nombres de los header de tabla

    # Definicion de las filas y columnas
    rows = len(driver.find_elements_by_xpath("/html/body/div[2]/div[2]/div/div/div/div[3]/table/tbody/tr"))
    cols = len(driver.find_elements_by_xpath("/html/body/div[2]/div[2]/div/div/div/div[3]/table/tbody/tr[1]/th"))
    print(rows)
    print(cols)

    # Recorrido por fila y columna.
    # Alineado de elementos dentro de 'data['']' según definición de headers.
    for r in range(2, rows + 1):
        data['Fecha'] = driver.find_element_by_xpath(
            "/html/body/div[2]/div[2]/div/div/div/div[3]/table/tbody/tr[" + str(r) + "]/td[1]").text
        data['N.Documento'] = driver.find_element_by_xpath(
            "/html/body/div[2]/div[2]/div/div/div/div[3]/table/tbody/tr[" + str(r) + "]/td[2]").text
        data['Entidad'] = driver.find_element_by_xpath(
            "/html/body/div[2]/div[2]/div/div/div/div[3]/table/tbody/tr[" + str(r) + "]/td[3]").text
        data['Materia'] = driver.find_element_by_xpath(
            "/html/body/div[2]/div[2]/div/div/div/div[3]/table/tbody/tr[" + str(r) + "]/td[4]").text
        df1 = df1.append(data, ignore_index=True)
        print(df1)
    # Creacion documento
    df1.to_csv('Hechos esenciales - Valores Extranjeros')
