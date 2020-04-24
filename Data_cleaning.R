# load library
library(tidyverse)

#load the dataset
data <- read_csv("Drug_Overdose.csv", col_names = TRUE)

#checking structure & features of the data
str(data)
head(data, 20)
length(unique(data$`State Name`))
colnames(data)
str_sort(unique(data$`State Name`))

# Names to remove from State Name Column
# "District of Columbia"
# "New York City"

# See the data in a new window
View(data)

# Filter out columns & change names of columns
data <- data %>% select(`State Name`, Year, Month, `Data Value`, Indicator) %>% 
  rename(Deaths = "Data Value", State = "State Name")

# Checking column name & dimensions
colnames(data)
dim(data)

# Checking # of missing values in each year data
data %>% group_by(Year) %>% count(NAs = is.na(Deaths)) %>% filter(NAs == TRUE)

# Filtering out data without NAs
data <- data %>% filter(!is.na(Deaths), 
                        Indicator %in% c("Number of Drug Overdose Deaths",
                                         "Number of Deaths",
                                         "Opioids (T40.0-T40.4,T40.6)",
                                         "Heroin (T40.1)",
                                         "Methadone (T40.3)",
                                         "Cocaine (T40.5)"))

data <- data %>%  mutate(Indicator = ifelse(
                                  Indicator == 
                                    "Number of Drug Overdose Deaths",'Overdose Deaths', ifelse(
                                      Indicator ==
                                      "Number of Deaths", "Total Deaths", ifelse(
                                        Indicator ==
                                        "Opioids (T40.0-T40.4,T40.6)", "Opioids Deaths", ifelse(
                                          Indicator ==
                                            "Heroin (T40.1)", "Heroin Deaths", ifelse(
                                              Indicator ==
                                                "Methadone (T40.3)", "Methadone Deaths", ifelse(
                                                  Indicator ==
                                                    "Cocaine (T40.5)", "Cocaine Deaths", Indicator)
))))))

# checking the column names
unique(data$Indicator)

# Saving the cleaned version of the csv file
write_csv(data, path = './cleaned_data.csv')















