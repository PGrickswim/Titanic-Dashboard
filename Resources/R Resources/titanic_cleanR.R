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



#See Table of Gender
#table(titanicR$gender)


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

#Trying ANOVA for age/survived
aov(age ~ survived, data=titanicR)
#To retrieve the p-values we have to wrap our aov function in a summary function
summary(aov(age ~ survived, data=titanicR))

#Trying ANOVA for gender/survived
aov(gender ~ survived, data=titanicR)

table(titanicR$gender)
table(titanicR$survived)

#Main effect option?
#https://rpubs.com/prasanna_date/217915

## Chi-Square Test
#null : variables are independent

library(MASS)

#chi-squared gender/survived
gen_surv = table(titanicR$survived, titanicR$gender)

gen_surv

chisq.test(gen_surv)

#chi-squared age/survived
age_surv = table(titanicR$survived, titanicR$age) #make variable
age_surv #call variable
chisq.test(age_surv) #run chi-squared

#chi-squared embarked/survived
embark_surv = table(titanicR$survived, titanicR$embarked) #make variable
embark_surv #call variable
chisq.test(embark_surv) #run chi-squared

#chi-squared class/survived
class_surv = table(titanicR$survived, titanicR$class) #make variable
class_surv #call variable
chisq.test(class_surv) #run chi-squared



