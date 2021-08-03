Para la realización del scrap se utilizó el paquete Selenium, ya que la naturaleza de la página corresponde a una página web dinámica.
Se destaca la posibilidad de realizar este con Rstudio, a través del paquete RSelenium.

Selenium es una herramienta, que a través de un driver, genera una navegación web simulada. Este permite la navegación a través de la definición de un url. 
Cabe señalar que la composición web de cada página puede variar, ya sea de manera fija; para caso de scrapping de tabla; o dinámica, para el caso de elementos que se carguen a medida que el usuario interactue con la página (generalmente a través de scrol o clicks).

En efecto, una vez se genera la navegación web, se procede a determinar los elementos a extraer; estos se ubican detro de "divs", definidos en referencias "a" "href"; class; o Paths(elementos codificados en HTML).

Adicionalmente, se destaca un modelo de extracción de links, referente a los contenidos 'href' que pueden existir dentro de un código HTML. La extracción de los urls asociados a los elementos a scrapear, facilitan la extracción de data de manera indirecta, evadiendo las posibles
interacciones con la web, a través del driver.

Así,a modo ilustrativo, se efectuó un scrap a la página web de retail, generando un pequeño dataset con información relativa a productos, precios y marcas.
