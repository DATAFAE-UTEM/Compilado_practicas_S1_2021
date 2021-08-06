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
#directorio con archivos
my_dir <- ('')
files <- list.files(path = my_dir, pattern = "pdf$")
setwd(my_dir)

# Extracción de texto
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
  pages_pdf <- ifelse(pages_pdf>5,5,pages_pdf) # Aca se delimita el n° de paginas deseadas a extraer. Recordas el [intervalo] cerrado. el 5 es un ejemplo
  
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

# donde se generará el data
output_dir <- '/'
# nombre del data
file_dir <- ''

# Generación de data
write.table( Data_text,  
             file = paste(output_dir, file_dir), 
             append = T, 
             sep=',', 
             row.names=F)

# Data final
data1 <- read_csv('') #Ingresar link de donde se guarda el .csv
