# Day 7
The skript from yesterday dident worked so we treid this one:
```
#!/bin/bash
#SBATCH --job-name=pub_data
#SBATCH --output=pub_data.out
#SBATCH --error=pub_data.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH	--qos=long
#SBATCH --time=0-05:00:00
#SBATCH --partition=all
#SBATCH --reservation=biol217

source ~/.bashrc

module load miniconda3/4.7.12.1
module load python/3.7.4
conda activate /home/sunam226/.conda/envs/reademption
################################### ---CALCULATIONS---
#aligning:
reademption align --fastq -f READemption_analysis --poly_a_clipping --min_read_length 12 --segemehl_accuracy 95  

# coverage:
reademption coverage -p 4 --project_path READemption_analysis 

#gene wise quanty:
reademption gene_quanti -p 4 --features CDS,tRNA,rRNA --project_path READemption_analysis 

#differential gene expression:
reademption deseq -l sRNA_R1.fa,sRNA_R2.fa,wt_R1.fa,wt_R2.fa -c sRNA,sRNA,wt,wt \
	-r 1,2,1,2 --libs_by_species Methanosarcina=sRNA_R1,sRNA_R2,wt_R1,wt_R2 --project_path READemption_analysis

############################## ---PLOTS---
reademption viz_align --project_path READemption_analysis
reademption viz_gene_quanti --project_path READemption_analysis
reademption viz_deseq --project_path READemption_analysis
conda deactivate
jobinfo
```




### R Studio
to get working directory
```
getwd()
``` 

this is how you set a working directory
```
setwd()
```
to create a folder
```
dir.create('data')
```
to create a folder in a folder
```
dir.create('data/raw_data')
```
list the files and directories
```
list.files()
```
class() to find out the category of your variable

`numeric:`
```
x <- 5
```
`character:`
```
x <- 'Hello World'
```
`logical:`
```
x <- TRUE
```
`raw:`
```
x <- charToRaw('Hello World')
```
`data.frame:`
```
 x <- data.frame(matrix(1:6, nrow = 2, ncol = 3))
  ```
dataset from R
```
 data("iris")
 ```
 open the dataset:
 ```
View(iris) 
```
Shows class of Species in the table iris:
```
class(iris$Species) 
```


### Plots
```
plot(iris)
```
```
boxplot(data=iris, x=iris$Sepal.Width)
```
all boxplots of sepal length for all species on their own:
```
boxplot(data=iris, iris$Sepal.Length~iris$Species)
```


### Plotting - install the package 
Install ggplot:
```
install.packages("ggplot2")
```
To activate the installed package:
```
library(ggplot2) 
```
install serveral packages together:
```
install.packages(c('readxl', 'plotly'))
```
Install tidyverse:
```
install.packages("tidyverse")
```

### GGplot
Define:
 1. data 
 2. mapping
 3. geometric
```
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length)) + geom_col()
```
e.g.
```
ggplot(data = iris, mapping = aes(x = iris$Species, y = iris$Sepal.Length)) + geom_boxplot()
```
change the color:
```
ggplot(iris, mapping = aes(Petal.Length, Sepal.Length, col = Species)) + geom_point()
```
change the shape
```
ggplot(iris, mapping = aes(Petal.Length, Sepal.Length, shape = Species)) + geom_point()
```
change the size
```
ggplot(iris, mapping = aes(Petal.Length, Sepal.Length, size = Petal.Width)) + geom_point()
```

`saving a plot`
```
plot1 <- ggplot(iris, mapping = aes(Petal.Length, Sepal.Length, size = Petal.Width)) + geom_point()
```
save as pdf
```
plot1 + ggsave('plot1.pdf',height = 6 , width = 8, units = 'in', dpi = 300)
```
save as png
```
plot1 + ggsave('plot1.png',height = 6 , width = 8, units = 'in', dpi = 300)
```
save as tiff (12.4 MB)
```
plot1 + ggsave('plot1.tiff',height = 6 , width = 8, units = 'in', dpi = 300)
```
save as compressed tiff (128.2 KB)
```
plot1 + ggsave('plot2.tiff',height = 6 , width = 8, units = 'in', dpi = 300, compression = 'lzw')
```

Istall tidyr
```
library(tidyr)
```
```
spread(iris, Species, value = )
```
### How to spread the data in R?
### Answer: 


Dispersion - How much data spread around mean. We just watched all variables and lokked which is normalized.
```
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
hist(iris$Petal.Length)
hist(iris$Petal.Width)
```
The one which was normalized we made a boxplot:
```
boxplot(iris$Sepal.Width)
```

At the end we tried on our own with a dataset of choice to do some plots:
```
data("ChickWeight")
```
ggplot(data = ChickWeight, mapping = aes(x = ChickWeight$Time, y = ChickWeight$weight, col = ChickWeight$Diet)) + geom_point()

ggplot(data = ChickWeight, mapping = aes(x = ChickWeight$Time, y = ChickWeight$weight, fill = ChickWeight$Diet)) + geom_boxplot()

ggplot(data = ChickWeight, mapping = aes(x = ChickWeight$Time, y = ChickWeight$weight, col = ChickWeight$Diet)) + geom_tile()

![image] 5 Plots of dataset!