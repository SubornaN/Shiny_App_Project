# Loding Libraries
library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)

# loading data
data <- read_csv('./cleaned_data.csv')
View(data)


#### Choices
YearID <- unique(data$Year)
locationID <- data %>% filter(Location != 'United States') %>% distinct(Location)
Rate.TypeID <- unique(data$`Rate Type`)

######################### Overview

# Line Graph of Death Rates
data %>% filter(Location == 'United States') %>% 
  ggplot(aes(x = Year, y = `Rate`, group = `Rate Type`)) +
  geom_point() + geom_line(aes(color = `Rate Type`)) + 
  theme(legend.position="bottom") +
  ggtitle('Trends of All Overdose & Opioid Death Rates') + 
  ylab("Death Rates (per 100,000 Population)")

# Bar Graph of Death Rates
data %>% filter(Location == 'United States') %>% 
  ggplot(aes(x = Year, y = `Rate`, fill = `Rate Type`)) +
  geom_col(position = 'dodge') + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  scale_x_continuous(breaks = c(2009:2018)) + labs(title = ) + 
  ylab("Death Rates (per 100,000 Population)") + 
  ggtitle('Death Rates Comparison of All Overdose & Opioid')

data %>% filter(Location == 'United States')

##################### Interactive Graphs

# For a given state Bar Graphs
data %>% filter(Location == 'Nevada') %>% 
  ggplot(aes(x = Year, y = `Rate`, fill = `Rate Type`)) +
  geom_col(position = 'dodge') + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  scale_x_continuous(breaks = c(2009:2018)) + labs(title = 'State Comparison of All Overdose & Opioid Death Rate') + 
  ylab("Death Rates (per 100,000 Population)")

# For a given state Line Graphs
data %>% filter(Location == 'Nevada') %>% 
  ggplot(aes(x = Year, y = `Rate`, group = `Rate Type`)) +
  geom_point() + geom_line(aes(color = `Rate Type`)) + 
  ggtitle('Trends of Opioid & All Overdose Death Rates') + 
  ylab("Death Rates (per 100,000 Population)")

# Top 3 States with Opioid Death Rates
data %>% filter(Location != 'United States', 
                `Rate Type` == 'Opioid Overdose Death Rate', Year == 2009) %>% 
  group_by(Year, `Rate Type`) %>% top_n(5)

################# Map

rate <- data %>% filter(Location != "United States") %>%  arrange(Location)
View(rate)
dim(rate)

abb <- read_csv('State_Abb.csv')
abb <- abb %>% filter(State != 'District of Columbia') %>% select(-Abbrev)

abb <- rbind.data.frame(abb,abb,abb,abb, 
                      abb,abb,abb,abb, 
                      abb,abb,abb,abb, 
                      abb,abb,abb,abb,
                      abb,abb,abb,abb) %>% rename(Location = State) %>% arrange(Location)
View(abb)

rate <- cbind(abb$Code, rate)

rate <- rate %>% rename(Code = `abb$Code`)

View(rate)










