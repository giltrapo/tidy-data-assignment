## Comprueba que existe la carpeta "UCI HAR Dataset" en nuestro directorio
## de trabajo
if(!file.exists("./UCI HAR Dataset")) {
        message("Por favor, descarga y descomprime los datos necesarios 
                para realizar el proyecto en tu directorio de trabajo")
        } else {
                message("OK, tienes los datos necesarios")
        }

## 1. Merges the training and the test sets to create one data set

## Leemos los ficheros subject_test.txt y subject_train.txt
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt")
## Comprobamos sus dimensiones
dim(subject_test)
dim(subject_train)
## Damos nombre a las variables
names(subject_test) <- "subject"
names(subject_train) <- "subject"

## Leemos los ficheros activity_test.txt y activity_train.txt
activity_test = read.table("./UCI HAR Dataset/test/y_test.txt")
activity_train = read.table("./UCI HAR Dataset/train/y_train.txt")
## Comprobamos sus dimensiones
dim(activity_test)
dim(activity_train)
## Damos nombre a las variables
names(activity_test) <- "activity"
names(activity_train) <- "activity"

## Leemos los ficheros X_test.txt y X_train.txt
features_test = read.table("./UCI HAR Dataset/test/X_test.txt")
features_train = read.table("./UCI HAR Dataset/train/X_train.txt")
## Comprobamos sus dimensiones
dim(features_test)
dim(features_train)
## Leemos el fichero features.txt, que contiene los nombres del
## vector de características
varnames = read.table("./UCI HAR Dataset/features.txt", 
                      stringsAsFactors = FALSE)
## Comprobamos sus dimensiones
dim(varnames)
## Damos nombre a las variables con los valores de features.txt
names(features_test) <- varnames[,2]
names(features_train) <- varnames[,2]

## Unimos en un mismo objeto la columna con la identificación del
## participante, la de la actividad que estaba realizando y el
## vector de características resultante, tanto para el grupo test
## como para el grupo entrenamiento
testdb = cbind(subject_test, activity_test, features_test)
traindb = cbind(subject_train, activity_train, features_train)

## Unimos en un mismo objeto las filas del test y del entrenamiento,
## atendiendo al nombre de las columnas
totaldb = rbind(testdb, traindb)



## 2. Extracts only the measurements on the mean and standard deviation
## for each measurement.

## Seleccionamos las variables que contienen las palabras "mean" o "std" 
selectdb <- totaldb[, c("subject", "activity", 
                    names(totaldb)[grepl("mean|std", names(totaldb))])]
## Eliminamos las variables con el texto "menFreq" 
selectdb <- selectdb[, !grepl("meanFreq", names(selectdb))]



## 3. Uses descriptive activity names to name the activities in the
## data set

## Leemos el fichero activity_labels.txt para ver los códigos de cada
## actividad
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt", 
                             stringsAsFactors = FALSE)

## Reemplaza los valores numéricos de la variable activity por texto
## que describe cada actividad, y convierte la variable en factor
selectdb$activity[selectdb[,2] == activity_labels[1,1]] <- activity_labels[1,2]
selectdb$activity[selectdb[,2] == activity_labels[2,1]] <- activity_labels[2,2]
selectdb$activity[selectdb[,2] == activity_labels[3,1]] <- activity_labels[3,2]
selectdb$activity[selectdb[,2] == activity_labels[4,1]] <- activity_labels[4,2]
selectdb$activity[selectdb[,2] == activity_labels[5,1]] <- activity_labels[5,2]
selectdb$activity[selectdb[,2] == activity_labels[6,1]] <- activity_labels[6,2]

## 4. Appropriately labels the data set with descriptive variable names. 

## Eliminamos y/o sustituimos algunos caracteres de los nombres
names(selectdb) <- gsub( "\\(|\\)" , "" , names(selectdb))
names(selectdb) <- gsub( "\\-|\\," , "." , names(selectdb))



## 5. From the data set in step 4, creates a second, independent tidy
## data set with the average of each variable for each activity and
## each subject.

## Crea un nuevo data frame con la media de cada variable para cada actividad
## y cada sujeto
tidydb <- aggregate(.~subject + activity, selectdb, mean)
write.table( tidydb, "tidydb.txt", row.names = FALSE)
