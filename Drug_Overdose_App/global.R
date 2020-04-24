# Loding Libraries
library(shiny)
library(shinydashboard)
library(tidyverse)


# loading data
data <- read_csv('./cleaned_data.csv')

choice1 <- colnames(data)
