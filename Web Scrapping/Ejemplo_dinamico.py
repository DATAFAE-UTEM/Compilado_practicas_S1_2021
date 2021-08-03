from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as Ec
from selenium.webdriver.chrome.options import Options


# Set de opciones del navegador
# Google Chrome
chrome_options = Options()
chrome_options.add_argument("--incognito")
chrome_options.add_argument("--window-size=1920x1080")

# Set del driver
driver = webdriver.Chrome(options=chrome_options,
                          executable_path="C:\\Program Files (x86)\\chromedriver.exe") # ubicacion del driver en C:\\

# url a navegar
url = "https://www.falabella.com/falabella-cl/category/cat20002/Moda-Mujer?isPLP=1"
driver.get(url)

# Interacion con pagina, haciendo scrol hasta el final de la pagina.
# Esto se debe principalemente, a que la pagina es una pagina dinamica, y con esta interaccion
# cargamos los elementos.
driver.execute_script("window.scrollTo(0,document.body.scrollHeight)")

# Scrap con condicion basada en definicion y aparicion de elementos
try:

    main = WebDriverWait(driver, 10). until(
        Ec.presence_of_element_located((By.XPATH, "//*[@id='testId-searchResults-products']"))
    )

    products = main.find_elements_by_class_name("grid-pod")

    for product in products:
        # nombre, precio y marca
        name = product.find_element_by_class_name("pod-subTitle")
        price = product.find_element_by_css_selector(".price-0 .cmr-icon-container")
        brand = product.find_element_by_class_name("pod-title")
        print(name.text, price.text, brand.text)

finally:
    # cerrar el driver siempre con este comando
    driver.quit()
