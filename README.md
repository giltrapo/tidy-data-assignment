Introducción
=====

Este repositorio contiene el material y la información necesaria para replicar el proyecto del curso Getting and Cleaning Data de Coursera.

En él podrás encontrar los siguientes ficheros:

* "README.md": es el fichero que estás leyendo en estos momentos, y en él se ofrece información sobre los datos con los que se ha trabajado en el proyecto, se explica el proceso seguido para realizarlo y se dan las instrucciones necesarias para ejecutar el script que permite reproducir en R dicho proceso.
* "run_analysis.R": script que permite reproducir en R los pasos seguidos para obtener y limpiar los datos, y para obtener la base de datos que se solicita en el proyecto.
* "tidydataset.txt": base de datos con las medias, por sujeto y actividad, de las variables solicitadas en el proyecto.
* "CodeBook.md": enumeración y descripción de las variables contenidas en el data set "tidydataset.txt".



Obteniendo los datos
====

El script contenido en el fichero "run_analysis.R" no contempla la descarga de los datos con los que se trabajará a lo largo del proyecto, y da por supuesto que ya los tienes descargados en tu directorio de trabajo. No obstante, puedes utilizar el siguiente código para descargarlos, si no lo has hecho aun:


	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

	## Descarga del fichero .zip para usuarios con Mac
	download.file(fileUrl,destfile="./dataset.zip",method="curl")

	## Descarga del fichero .zip para usuarios con Windows. Este método funciona correctamente
	## con R version 3.2.0 (2015-04-16) -- "Full of Ingredients", y con RStudio Version 0.99.442 
	download.file(fileUrl,destfile="./dataset.zip",method="libcurl")

Una vez descargados los datos en tu directorio de trabajo, puedes descomprimir el fichero "dataset.zip"
con el siguiente código:

	unzip("dataset.zip")

Y, opcionalmente, puedes eliminar el fichero "dataset.zip" con este código:

	file.remove("dataset.zip")

	
	
Antecedentes del experimento
====

El archivo .zip que nos hemos descargado de la url anterior contiene una carpeta llamada "UCI HAR Dataset" donde se encuentran todos los ficheros necesarios para realizar el proyecto. Para que el código de "run_analysis.R" funcione, debemos tener la carpeta "UCI HAR Dataset", con todo su contenido, en nuestro directorio de trabajo. Por tanto, lo primero que tenemos que hacer es comprobar que dicha carpeta se encuentra en nuestro directorio de trabajo.

La carpeta "UCI HAR Dataset" contiene datos relativos a un experimento en el que 30 personas de entre 19 y 48 años realizaron una serie de actividades (caminar, subir escaleras, bajar escaleras, sentarse, permanecer de pie y tumbarse) llevando un móvil Samsung Galaxy S II en la cintura, que recogía datos relativos a la aceleración y velocidad angular de los participantes mientras realizaban dichas actividades. El objetivo de dicho experimento era intentar predecir la actividad que estaba realizando cada individuo a partir de los datos recogidos por el smartphone. Por esta razón dividieron los datos en dos grupos, uno con el 70% de los participantes, que utilizaron para entrenar los modelos predictivos, y otro con el 30% restante, que sirvió para testar la eficacia de los modelos.


Limpiando y ordenando los datos
====

Dentro de la carpeta "UCI HAR Dataset" se encuentran los siguientes elementos:

* "train": directorio que contiene ficheros con los datos de los participantes asignados al grupo de entrenamiento
* "test": directorio que contiene ficheros con los datos de los participantes asignados al grupo de test
* "activity_labels.txt": fichero con 6 filas y 2 columnas. Cada fila se corresponde con una actividad. La primera columna contiene dígitos, del 1 al 6. La segunda columna contiene las etiquetas de cada actividad.
* "features.txt": fichero con 561 filas y 2 columna. Cada fila se corresponde con el nombre de una variable. La primera columna contiene dígitos, del 1 al 561. La segunda columna contiene las etiquetas de cada variable.

La estructura de los datos de las carpetas train y test es la misma: hay una carpeta llamada "Inertial Signals" que contiene las mediciones recogidas a través de los sensores del smartphone, un fichero que contiene el identificador del participante, otro con el identificador de la actividad y un último fichero con una serie de variables obtenidas a partir de las mediciones que se encuentran en la carpeta "Inertial Signals". Vamos a examinarlos más detenidamente:

#### Participantes
Leemos los ficheros "subject_test.txt" y "subject_train", y creamos los objetos "subject_test" y "subject_train", que tienen 2,947 filas y 7,352 filas, respectivamente. Ambos ficheros tienen una sola columna, a la que vamos a llamar "subject". Esta variable es de tipo integer, y contiene digitos que identifican al participante. Si contamos los identificadores únicos de los participantes encontramos que en el grupo de test hay 9 participantes (30% de 30) y en el de entrenamiento 21 (70% de 30).

#### Actividades
Leemos los ficheros "y_test.txt" y "y_train.txt", y creamos los objetos "activity_test" y "activity_train", que tienen 2,947 filas y 7,352 filas, respectivamente. También tienen una sola columna, a la que vamos a llamar "activity". Es una variable de tipo integer, e identifica la actividad que realiza cada participante. Contando los identificadores únicos de cada actividad se observa que en ambos grupos se han realizado las 6 actividades.

#### Vector de características
Leemos los ficheros "X_test.txt" y "X_train.txt", y creamos los objetos "features_test" y "features_train", que tienen 2,947 filas y 7,352 filas, respectivamente. El número de columnas de ambos objetos es de 561. Estas columnas son variables que se han obtenido aplicando una serie de transformaciones a los datos de los ficheros contenidos en la carpeta "Inertial Signals". En el fichero "features.txt", que hemos visto anteriormente, están los 561 nombres de estas variables. Utilizamos dicho fichero para darle nombre a estas 561 columnas.

#### Inertial Signals
En esta carpeta hay datos relativos a la aceleración total, la aceleración estimada del cuerpo y la velocidad angular de los participantes. Como estas mediciones se realizaron en un espacio tridimensional, se recogieron datos de los ejes X, Y y Z para cada una de ellas. Hay, por tanto, 9 ficheros.

Los ficheros contenidos en la carpeta "Inertial Signals" del grupo "test", tienen 2,947 filas y 128 columnas, mientras que los del grupo "train" tienen 7,352 filas y 128 columnas. Las filas coinciden con las que tienen los ficheros de participantes y actividades respectivos. Las columnas, según la información del fichero "README.txt", se refieren a la cantidad de mediciones realizadas en una ventana de tiempo de 2.56 segundos. Esto significa que cada 2.56 segundos se obtiene una línea con 128 medidas de cada una de las tres magnitudes (aceleracion total, aceleración del cuerpo y velocidad angular) y para cada uno de los tres ejes. No hay ningún fichero con los nombres para estas 128 variables. 

Hasta ahora hemos visto que los ficheros del grupo test tienen 2,947 filas, mientras que los del grupo de entrenamiento tienen 7,352 filas. Cada una de esas filas se corresponde con las mediciones recogidas en 2.56 segundos a un participante concreto realizando una actividad concreta.


## 1. Merges the training and the test sets to create one data set.
El primer objetivo del proyecto es obtener un objeto con los datos del grupo de entrenamiento y del grupo test, es decir, añadir las filas de uno de los grupos a las del otro, haciendo que coincidan las columnas.

Antes de hacer esto vamos a identificar cada fila de los objetos "features_test" y "features_train" con el participante correspondiente y la actividad que estaba realizando en esa ventana de tiempo. Como no hay ningún identificador común entre los objetos "subject_test", "activity_test" y "features_test", suponemos que están ordenados de igual forma, por lo que únicamente tenemos que unir las columnas, manteniendo el orden de las filas, y creamos el objeto "test". Hacemos lo mismo con "subject_train", "activity_train" y "features_train", y creamos el objeto "train".

Ahora tenemos un objeto "testdb" con 2,947 filas y 563 columnas, y un objeto "traindb" con 7,352 filas y 563 columnas. Vamos a unir las filas de ambos objetos para obtener el objeto "totaldb", con 10,299 filas y 563 columnas.

No vamos a unir los datos que se incluyen en las carpetas "Inertial Signals", porque para el proyecto sólo se van a utilizar los datos del vector de características.


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
El siguiente objetivo del proyecto es seleccionar unicamente aquellas variables que recogen la media o la desviación típica de las diferentes señales obtenidas a partir de los sensores del smartphone. Echando un vistazo al fichero "features_info.txt", observamos lo siguiente:

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Por tanto vamos a seleccionar aquellas columnas en cuyo nombre se encuentren los textos "mean()" o "sd()". Hay 33 variables con el texto "mean()" y otras 33 variables con el texto "std()".

Vemos también que para determinadas columnas se ha calculado también algo llamado "meanFreq()". Se trata de una especie de media ponderada. Estas estimaciones no tienen aparejada una desviación típica, como sí ocurre con las variables que llevan incluido el texto "mean()" (por cada variable con el texto "mean()" hay otra con el texto "sd()"). Por tanto, vamos a eliminar las 13 columnas que contienen el texto "meanFreq()".

Finalmente obtenemos un data frame llamado "selectdb", con 10,299 filas y 68 columnas. 


## 3. Uses descriptive activity names to name the activities in the data set
Para sustituir los códigos de cada actividad por un texto que indique la descripción de la actividad, vamos a abrir primero el archivo "activity_labels.txt", asegurándonos de que los textos no son interpretados como una variable factor, porque nos puede dar problemas a la hora de sustituir. Vamos a utilizar el data frame que acabamos de generar con las actividades del experimento, para sustituir cada código de la variable "activity" contenida en el data frame "selectdb", por el texto de la actividad correspondiente.


## 4. Appropriately labels the data set with descriptive variable names. 
Limpiamos un poco los nombres de las columnas, eliminando los paréntesis y sustituyendo los guiones y las comas por puntos.


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Antes de comenzar esta tarea, vamos a examinar más a fondo la base de datos "selectdb". Para ellos vamos a obtener una tabla cruzando las personas que han participado en el experimento (30) con las actividades que han realizado (6).

La tabla resultante indica cuántas líneas del data base selectdb tiene una persona determinada en una actividad determinada. Así, para la actividad "LAYING", la persona 1 tiene 50 líneas, la persona 2 tiene 48 líneas, la persona 3 tiene 62 líneas, etc. Esto significa que en la actividad "LAYING", la persona 1 tiene 50 valores de cada una de las 66 variables que hemos seleccionado, la persona 2 tiene 48 valores de dichas variables, la persona 3 tiene 62, etc.

El objetivo es, por tanto, que cada persona tenga, para cada una de las actividades que ha realizado, el valor promedio de cada una de las 66 variables.

Por tanto, podríamos calcular a priori las dimensiones de la base de datos que queremos obtener. El número de columnas será el mismo que tiene ahora el data set "selectdb". El número de filas será el del numero de participantes multiplicado por el número de actividades distintas. Esto da un total de 180 filas. Vamos a obtener el data set y a guardarlo.





Anexo: Entendiendo la relación entre Inertial Signasl y Vector Features
====
En este proyecto no ha sido necesario utilizar los datos contenidos en la carpeta "Inertial Signals", pero es conveniente entender cuál es su relación con los datos de los ficheros "X_test.txt" y "X_train.txt", es decir, con el vector de características. 

Veamos, por ejemplo, cómo se han calculado los valores de la primera variable de este vector: "tBodyAcc-mean-X()".

La columna "tBodyAcc-mean-X()" del data set "totaldb" muestra 10,299 valores medios de la aceleración del cuerpo de los participantes en el eje X, normalizados en un rango de -1 a 1. Estas 10,299 filas, como hemos visto anteriormente, son las 10,299 ventanas de tiempo de 2.56 segundos que se han muestreado durante la realización del experimento. Esto significa que los 30 participantes estuvieron realizando actividades, mientras el smartphone recogía datos sobre su acelaración y velocidad angular, durante unas 7 horas y 19 minutos. 

Los datos de aceleración del cuerpo en el eje X están en los ficheros "body_acc_x_test.txt" y "body_acc_x_train.txt". Los leemos y creamos los objetos "body_acc_x_test" y "body_acc_x_train", que tienen 2,947 filas y 7,352 filas, respectivamente. El número de columnas de ambos objetos es de 128, que se corresponden con el numero de mediciones que se realizaban en esa ventana de tiempo de 2,56 segundos. Unimos, en función de las columnas, ambos objetos y obtenemos un data set llamado "body_acc_x", con 10,299 filas y 128 columnas.

	body_acc_x_test = read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
	body_acc_x_train = read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
	body_acc_x = rbind(body_acc_x_test, body_acc_x_train)
	dim(body_acc_x)

Ahora calculamos las medias de las filas. Creamos un data frame con estos valores medios, y le damos un nombre a la variable.

	body_acc_x_mean <- as.data.frame(x = apply(body_acc_x, 1, mean))
	names(body_acc_x_mean) <- "body_acc_x_mean"

Normalizamos dichos valores, en un rango de -1 y 1, y los añadimos a una nueva variable.

	body_acc_x_mean$body_acc_x_mean_norm = 2*(body_acc_x_mean[,1] - min(body_acc_x_mean[,1]))/(max(body_acc_x_mean[,1]) - min(body_acc_x_mean[,1])) - 1

Los datos de esta columna que acabamos de añadir, "body_acc_x_mean_norm", deberían de coincidir con los datos de la columna "tBodyAcc-mean-X()" del data set total. Vamos a añadirla, y comparamos.

	body_acc_x_mean$body_acc_x_mean_norm2 = total[,3]

Se observa que los valores coinciden.

Como se ha visto, la variable tBodyAcc-mean-X() se obtiene calculando las medias de los 128 valores de aceleración del cuerpo en el eje X, y luego normalizándolas. Esto mismo se hace con los datos de los ejes Y y Z, y también con los datos relativos a la gravedad y la velocidad angular. Además de las medias se calculan desviaciones típicas, medianas, valores máximos, valores mínimos, etc. En algunos casos, en vez de calcular estos estadísticos sobre los valores de los ficheros body_acc, body_gyro y total_acc, se realiza algún tipo de transformación sobre ellos, como calcular sus derivadas en función del tiempo, la Fas Fourier Transform (FFT) o la Euclidean Norm.

