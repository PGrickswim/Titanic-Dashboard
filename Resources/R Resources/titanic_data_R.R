titanic_data <- read.csv(file='titanic_clean.csv',check.names=F,stringsAsFactors = F)


library(ggplot2)
library(dplyr)
library(tidyverse)

##Changing data type
titanic_data$gender <- factor( as.character(titanic_data$gender))

#Making pie chart from bar plot

##Declare variable
gender

##Making Bar Plot
gender <- titanic_data %>% count(gender) %>%
  mutate(percentage = n/sum(n)*100 ,
  pos_pie = round(cumsum(percentage) - 0.5 * percentage, 2)) #to find center

head(gender)

##Bar Plot
ggplot() + geom_col(data=gender, mapping= aes(x=gender, y=percentage))

##Pie Chart
ggplot(data=gender) +
  geom_col( mapping = aes(x="", y = percentage, fill = gender)) +
  coord_polar(theta="y") +
  geom_text(aes(x = "", y = pos_pie,label = scales::percent(percentage, scale = 1)))

##Rewriting the data
gender <- titanic_data %>% count(gender) %>%
  arrange(desc(gender)) %>%
  mutate(percentage = n/sum(n)*100 ,
         pos_pie = round(cumsum(percentage) - 0.5 * percentage, 2)) #to find center



##New pie chart changing positions
ggplot(data=gender) +
  scale_fill_discrete(labels = c("Female", "Male")) + ##Change legend keys
  ggtitle("Gender Distribution Aboard Ship") +
  labs(fill="Sex") + #c  hange the legend title
  geom_col( mapping = aes(x="", y = percentage, fill = gender)) +
  coord_polar(theta="y") +
  geom_text(aes(x = "", y = pos_pie,label = scales::percent(percentage, scale = 1)))