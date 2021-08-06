# clean current workspace
#rm(list=ls(all=T))

# set options
options(stringsAsFactors = F)

# install packages
#install.packages("tesseract")
#install.packages("pdftools")
#install.packages("tidyverse")
#install.packages("wordcloud2")
#install.packages("tm")


# Activate packages
library(tesseract)
library(pdftools)
library(wordcloud2)
library(tm)
library(tidyverse)

#===========================================================================================#
# EXTRACCIÓN DE TEXTO #
#===========================================================================================#

# MODELO PARA DOCUMENTOS FORMATO PDF #

# Creación de Data y definición de url
Data_text = data.frame()

# Directorio
my_dir <- ('C://home//Desktop//analisis_de_texto//Datas//resoluciones_de_sanciones_cursadas')
files <- list.files(path = my_dir, pattern = "pdf$")
setwd(my_dir)

for(file in files){
  
  # Nombre de archivo
  Archivo = file
    
  # Estructura de Corpus
  corp = Corpus(URISource(file, encoding = "latin1"),
                readerControl = list(reader = readPDF, language = "es-419"))
  
  # Extracción de fecha
  Fecha = corp[[ file ]][["meta"]][["datetimestamp"]]
  
  #Páginas
  pages_pdf = pdf_info(file)$pages
  pages_pdf <- ifelse(pages_pdf>5,5,pages_pdf)
  
  # Transformación del texto
  pngfile = pdftools::pdf_convert(file,
                                  dpi = 200,
                                  pages = 1:pages_pdf)
  Texto = tesseract::ocr(pngfile)
  print(paste("vamos en el archivo", Archivo))
  
  # Transformación lista a párrafo
  Full_Texto <- ""
  
  for (i in Texto) {
    Full_Texto <- paste(Full_Texto, i)
  }
  
  Texto <- Full_Texto
  rm(Full_Texto)
  
  # Unión y limpieza
  Texto_limpio = Texto %>% paste(sep = " ") %>%
    stringr::str_replace_all(fixed("\n"), " ") %>%
    stringr::str_replace_all(fixed("\r"), " ") %>%
    stringr::str_replace_all(fixed("\t"), " ") %>%
    stringr::str_replace_all(fixed("\""), " ") %>%
    paste(sep = " ", collapse = " ")
  print(paste("ya se limpio el archivo", Archivo))
  
  # Construccion Dataset
  Data_text <- rbind(Data_text, data.frame(Archivo, Fecha, Texto_limpio))
}

# salida y nombre archivo
output_dir <- '/home/analisis_de_texto/Datas'
file_dir <- 'data_resoluciones_sanciones_cursadas.csv'

# generar data
write.table( Data_text,  
             file = paste(output_dir, file_dir), 
             append = T, 
             sep=',', 
             row.names=F)

# ver data
data1 <- read_csv('/home/analisis_de_texto/Datas/data_resoluciones_sanciones_cursadas.csv')
