# load library
library(tidyverse)

#load the dataset
data <- read_csv("Drug_Overdose.csv", col_names = TRUE)


dim(data)
colnames(data)

data <- data %>% filter(Location != "District of Columbia")

data_opioid <- data %>% select(Location, "2009__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2010__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2011__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2012__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2013__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2014__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2015__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2016__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2017__Opioid Overdose Death Rate (Age-Adjusted)",
                                         "2018__Opioid Overdose Death Rate (Age-Adjusted)")
data_opioid <- data_opioid %>% 
  gather(key = 'Year', value = 'Opioid Overdose Death Rate', 
                                      c("2009__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2010__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2011__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2012__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2013__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2014__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2015__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2016__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2017__Opioid Overdose Death Rate (Age-Adjusted)",
                                        "2018__Opioid Overdose Death Rate (Age-Adjusted)"))



data_opioid <- separate(data_opioid, Year, c("Year", "value"), sep = '__') %>%  select(-value)
data_opioid$Year <- as.numeric(data_opioid$Year)



data_all <- data %>% select(Location, "2009__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2010__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2011__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2012__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2013__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2014__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2015__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2016__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2017__All Drug Overdose Death Rate (Age-Adjusted)",
                                      "2018__All Drug Overdose Death Rate (Age-Adjusted)")

data_all <- data_all %>% gather(key = 'Year', value = 'All Overdose Death Rate', 
                                     c("2009__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2010__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2011__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2012__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2013__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2014__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2015__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2016__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2017__All Drug Overdose Death Rate (Age-Adjusted)",
                                       "2018__All Drug Overdose Death Rate (Age-Adjusted)"))

data_all <- separate(data_all, Year, c("Year", "value"), sep = '__') %>%  select(-value)
data_all$Year <- as.numeric(data_all$Year)



joined <- inner_join(data_opioid, data_all, by = c("Year", "Location"))



joined$`Opioid Overdose Death Rate` <- as.numeric(joined$`Opioid Overdose Death Rate`)
joined$`All Overdose Death Rate` <- as.numeric(joined$`All Overdose Death Rate`)
class(joined$Year)

joined <- joined %>% gather(`Opioid Overdose Death Rate`, 
                        `All Overdose Death Rate`, 
                        key = "Death Rate Types",
                        value = 'Death Rates')



joined <- joined %>% mutate(`Death Rate Types` = ifelse(
  `Death Rate Types` == 
    'Opioid Overdose Death Rate', 
  'Opioid Overdose', 'All Overdose'))

joined <- joined %>% rename(
  `Rate Type` = `Death Rate Types`,
  Rate = `Death Rates`)

joined <- joined %>% mutate(`Rate` = ifelse(
  is.na(`Rate`) == TRUE, 0, `Rate`)
)


# Saving the cleaned version of the csv file
write_csv(joined, path = './Drug_Overdose_App/cleaned_data.csv')







