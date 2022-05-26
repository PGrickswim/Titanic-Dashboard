library(ggplot2)
library(dplyr)
library(tidyverse)

#Import the CSV cleaned for r
titanicR <- read.csv(file='titanic_cleanR.csv',check.names=F,stringsAsFactors = F)

#Categorical Casting (run once without assignment and then add assignment)
titanicR$class <- as.factor(titanicR$class)
titanicR$gender <- as.factor(titanicR$gender)
titanicR$embarked <- as.factor(titanicR$embarked)
titanicR$survived <- as.factor(titanicR$survived)

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



