#to get working directory
getwd() 

#this is how you set a working directory
setwd()

#to create a folder
dir.create('data')#

#to create a folder in a folder
dir.create('data/raw_data')

#list the files and directories
list.files()

#class to find out the category of your variable
x <- 5
class(x) #numeric
x <- 'Hello World'
class (x) #character
x <- TRUE
class(x) #logical
x <- charToRaw('Hello World')
class(x) #raw
 x <- data.frame(matrix(1:6, nrow = 2, ncol = 3))
 class(x) #data.frame
 
 data("iris") #dataset from R
View(iris) #open the dataset
class(iris$Species) #shows class of Species in the table iris

plot(iris)
boxplot(data=iris, x=iris$Sepal.Width) #just one boxplot
boxplot(data=iris, iris$Sepal.Length~iris$Species) #all boxplots of sepal length for all species on their own


#Plotting - install the package 
install.packages("ggplot2")
library(ggplot2) #activate the package
#install serveral packages together
install.packages(c('readxl', 'plotly'))
install.packages("tidyverse")


#GGplot
#Define 1. data 2. mapping and 3. geometric

ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length)) + geom_col()

ggplot(data = iris, mapping = aes(x = iris$Species, y = iris$Sepal.Length)) + geom_boxplot()
#change the color
ggplot(iris, mapping = aes(Petal.Length, Sepal.Length, col = Species)) + geom_point()
#change the shape
ggplot(iris, mapping = aes(Petal.Length, Sepal.Length, shape = Species)) + geom_point()
#change the size
ggplot(iris, mapping = aes(Petal.Length, Sepal.Length, size = Petal.Width)) + geom_point()

#saving a plot
plot1 <- ggplot(iris, mapping = aes(Petal.Length, Sepal.Length, size = Petal.Width)) + geom_point()
#save as pdf
plot1 + ggsave('plot1.pdf',height = 6 , width = 8, units = 'in', dpi = 300)
#save as png
plot1 + ggsave('plot1.png',height = 6 , width = 8, units = 'in', dpi = 300)
#save as tiff (12.4 MB)
plot1 + ggsave('plot1.tiff',height = 6 , width = 8, units = 'in', dpi = 300)
#save as compressed tiff (128.2 KB)
plot1 + ggsave('plot2.tiff',height = 6 , width = 8, units = 'in', dpi = 300, compression = 'lzw')




































