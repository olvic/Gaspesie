#set wd
setwd("C:/Users/olivi/OneDrive/GIT/Gaspesie")


#####################  gapmakers  #############

#load gapmaker file
gapmaker <- read.table("gapmaker.txt", header = TRUE)
str(gapmaker)
gapmaker$Site<-as.factor(gapmaker$Site)

#get BA(m2) per tree size class
gapmaker$BA_diam <- (gapmaker$DBH/200)^2*pi
gapmaker$BA_sizeclass <-gapmaker$BA_diam*gapmaker$Freq

#get BA(m2) per gap
gapmakerBA<-aggregate(gapmaker$BA_sizeclass, by=list(Site=gapmaker$Site, Gap=gapmaker$Gap), FUN=sum)

#I now have the total basal area of all identified downed trees that formed the gap. This should
#be correlated with gap size, and we are likely not to be able to use both variables in the models.

#####################  gapfillers  #############

#load gapfiller files
gapfillers <- read.table("gapfillers.txt", header = TRUE)
str(gapfillers)
gapfillers$Site<-as.factor(gapfillers$Site)

#get average age for each gap
library(doBy)
gapage <- summaryBy(Age ~ Site + Gap, data=gapfillers, FUN=c(mean,sd))
