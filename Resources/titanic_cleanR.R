library(ggplot2)
library(dplyr)
library(tidyverse)

#Import the CSV cleaned for r
titanicR <- read.csv(file='titanic_cleanR.csv',check.names=F,stringsAsFactors = F)

#Reading data classes
#sapply(titanicR, class)

#Categorical Casting (run once without assignment and then add assignment)
titanicR$class <- as.factor(titanicR$class)
titanicR$gender <- as.factor(titanicR$gender)
titanicR$embarked <- as.factor(titanicR$embarked)
titanicR$survived <- as.factor(titanicR$survived)

 #Median of Age
#median(titanicR$age, na.rm=TRUE)

#Mean of Age
#mean(titanicR$age, na.rm = TRUE)

#See Table of Gender
#table(titanicR$gender)

#See Table of Embarker
#table(titanicR$embarked)

#RandomForest
#https://www.youtube.com/watch?v=Zx2TguRHrJE
survived.equation <- "survived ~ class + gender + age + embarked"
survived.formula <- as.formula(survived.equation)
install.packages("randomForest")
library(randomForest)

titanic.model<- randomForest(formula = survived.formula, data=titanicR, ntree = 500, mtry = 3, nodesize = 0.01 * nrow(titanicR))

features.equation <- "class + gender + age + embarked"
titanic.predictions <- predict(titanic.model, newdata = titanicR)

#Relationship between Gender and Survival 
ggplot(data = titanicR, aes(x = gender, fill = factor(survived))) + 
  geom_bar(stat = "count", position = "dodge") + 
  labs(x = "Survival by Gender") + 
  theme_bw()

#Relationship between Embarked and Survival 
ggplot(data = titanicR, aes(x = embarked, fill = factor(survived))) + 
  geom_bar(stat = "count", position = "dodge") + 
  labs(x = "Survival by Embarked Location") + 
  theme_bw()

#Relationship between Class and Survival 
ggplot(data = titanicR, aes(x = class, fill = factor(survived))) + 
  geom_bar(stat = "count", position = "dodge") + 
  labs(x = "Survival by Class") + 
  theme_bw()

#Relationship between age and survival
#https://rpubs.com/shivam2503/predictsurvival
ggplot(data = titanicR, aes(x = age, fill = factor(survived))) + 
  geom_histogram() + 
  facet_grid(.~gender) + 
  theme_bw()

#Trying ANOVA
aov(age ~ survived, data=titanicR)
#To retrieve the p-values we have to wrap our aov function in a summary function
summary(aov(age ~ survived, data=titanicR))
