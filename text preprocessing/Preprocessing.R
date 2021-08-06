library(stringi)
library(tm)
library(ggplot2)
library(tidyverse)
library(tidytext)
library(readr)
library(SnowballC)
library(textstem)
library(syuzhet)
library(dplyr)

# data con directorio; codificado en español
df = read.csv("", encoding="latin1") %>% tbl_df()

# Seleccion de columna con texto
df <- select(df, texto)

# Limpieza

# sacar los tildes
df$texto <- chartr('áéíóúñ','aeioun',df$Comentario)

# Df a corpus
myCorpus <- VCorpus(VectorSource(df$texto))

# pasar a Minuscula
myCorpus <- tm_map(myCorpus, content_transformer(tolower))

# quitar numeros
myCorpus <- tm_map(myCorpus, removeNumbers)

# quitar puntuacion
myCorpus <- tm_map(myCorpus, removePunctuation)

# Tokenizado
myCorpusTokenized <- lapply(myCorpus, scan_tokenizer)

# Lematizado
myCorpusLemmatized <- tm_map(myCorpus, lemmatize_strings)
myCorpusLemmatized <- tm_map(myCorpusLemmatized, removeWords, c(stopwords('spanish'),"ma","u"))
myCorpusLemmatized <- tm_map(myCorpusLemmatized, PlainTextDocument)

# Concatenar los corpus
myDf <- data.frame(text = sapply(myCorpusTokenized, paste, collapse = " "), stringsAsFactors = FALSE)
myDf2 <-data.frame(text = sapply(myCorpusLemmatized, paste, collapse = " "), stringsAsFactors = FALSE)
myDf3 <- data.frame(text = sapply(myCorpusTokeLemma, paste, collapse = " "), stringsAsFactors = FALSE)

# limpieza stopwords
myDf <- VCorpus(VectorSource(myDf$text))
myDf2 <- VCorpus(VectorSource(myDf2$text))
myDf3 <- VCorpus(VectorSource(myDf3$text))

myDf <- tm_map(myDf, removeWords, c(stopwords('spanish'),"ma","u"))
myDf2 <- tm_map(myDf2, removeWords, c(stopwords('spanish'),"ma","u"))
myDf3 <- tm_map(myDf3, removeWords, c(stopwords('spanish'),"ma","u"))

# Documento .csv con texto final.
Preprocessed_data_tokens = write.csv(myDf,'')
Preprocessed_data_Lemma = write.csv(myDf,'')
Preprocessed_data_tokeLemma = write.csv(myDf3,'')
