
########################### Loding Libraries ###########################
library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(RColorBrewer)

############################### loading data #############################

data <- read_csv('./cleaned_data.csv')
data <- data %>% arrange(Location, Year)

################################# Inputs ###################################

YearID <- sort(unique(data$Year), decreasing = TRUE)
LocationID <- data %>% filter(Location != 'United States') %>% distinct(Location)
Rate.TypeID <- unique(data$`Rate Type`)

########################## State Abbreviation for Map ######################

rate <- data %>% filter(Location != "United States") %>%  arrange(Location)

abb <- read_csv('State_Abb.csv')
abb <- abb %>% filter(State != 'District of Columbia') %>% select(-Abbrev)

abb <- rbind.data.frame(abb,abb,abb,abb, 
                        abb,abb,abb,abb, 
                        abb,abb,abb,abb, 
                        abb,abb,abb,abb,
                        abb,abb,abb,abb) %>% rename(Location = State) %>% arrange(Location)

rate <- cbind(abb$Code, rate)

rate <- rate %>% rename(Code = `abb$Code`)

##############################################################################











