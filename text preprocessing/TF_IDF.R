library(dplyr)
library(tidytext)

# Data con tokenizado y data con texto
# estas se llevan a Encoding y TF-IDF

data <- read_csv('', locale = readr::locale(encoding = "UTF-8"))
data <- select(data,text)

# Tokenizado de la información para transofmracion
comentario_tokens <- unnest_tokens(tbl= data,
                                   output = "word",
                                   input = "text",
                                   token = "words") %>% 
                     count(word, sort =TRUE)

#TF-IDF
# se crea un corpus con el texto limpio
corpu <- VCorpus(VectorSource(comentario_tokens))

# cantidad de archivos
length(corpu)

# stopwords personalizadas
myStopwords <- c( stopwords("spanish"),"") # acá se pueden agregar palabras no contenidas en el stopwords

# TDM aplicando la ponderación TF-IDF en lugar de la frecuencia del término
tdm <- TermDocumentMatrix(corpu,
                          control = list(weighting = weightTfIdf,
                                         stopwords = myStopwords,
                                         removePunctuation = T,
                                         removeNumbers = T))
tdm
inspect(tdm)

# frecuencia con la que aparecen los términos sumando el contenido de todos los términos (es decir, filas)
freq <- rowSums(as.matrix(tdm))
head(freq,10)
tail(freq,10)

# Trazar las frecuencias ordenadas
plot(sort(freq, decreasing = T),col="blue",main="Word TF-IDF frequencies", xlab="TF-IDF-based rank", ylab = "TF-IDF")

# 10 terminos mas frecuentes
tail(sort(freq),n=10)

# Términos más frecuentes y sus frecuencias en un diagrama de barras.
high.freq <- tail(sort(freq),n=10)
hfp.df <- as.data.frame(sort(high.freq))
hfp.df$names <- rownames(hfp.df)

ggplot(hfp.df, aes(reorder(names,high.freq), high.freq)) +
  geom_bar(stat="identity") + coord_flip() +
  xlab("Terms") + ylab("Frequency") +
  ggtitle("Term frequencies")
