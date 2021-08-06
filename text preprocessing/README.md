Este proceso se centra en la remoción de caracteres que puedan incidir en ruido dentro del análisis de sentimientos. Así, el proceso se centra en:

1) Remover los tildes: Eliminación de tildes asociados al idioma español. Esto evita errores asociados a la codificación de caracteres.
2) Conversión de mayúsculas en minúsculas: Para evitar el tratado erróneo de las oraciones.
3) Remover la puntuación: Eliminación de signos de puntuación, dados por ! 00 # $ % & ’ ( ) * + , - . / : ; < = > ? @ [ \ ] ˆ _ ‘ { | } ∼.
4) Remover números.
5) Remover espacios en blanco innecesarios.
6) Remover palabras poco relevantes (Stopwords): Para aumentar el rendimiento computacional, no tanto para mejorar la estimación, se decidió por eliminar las palabras más utilizadas en español; para este caso artículos, preposiciones, conjunciones, verbos y adjetivos más comunes,  pronombres y adverbios.

Una vez se efecta la limpieza de la data, esta se lleva a un proceso de tokenizado. Este proceso consta de la separacion de cadenas de texto en piezas mas pequeñas; tokens. Lo que facilita la normalización de la información de forma individual por palabra. 

Finalmente, la matriz TF-IDF permite la comprensión de la frecuencia de los terminos existentes en los corpus. Facilitando una comprension de las palabras mas frecuentes dentro de los documentos.


