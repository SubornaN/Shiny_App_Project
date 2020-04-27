# Shiny_App_Project

Background:
The purpose of this web application is to explore the impact of opioid overdose deaths on total overdose deaths across USA. The data was collected from Kaiser Family Foundation (KFF) website. It includes data on opioid overdose death rate and total overdose death rate, per state, by year from 2009 to 2018. The web application includes 4 tabs. The "Overview" tab gives an overview of yearly overdose death rates in USA. The "Interactive Graphs" tab shows state level analysis for drug overdose rate and lets users interact with the data. The "Map Visualization" tab shows a heat map of overdose deaths across USA. Lastly, the "Data Table" tab shows the data used to make this visualization web application.

Quick note:
For North Dakota, there were 6 missing data points from 2009 to 2013 for "Opioid Overdose" death rate and 1 missing data point for 2011 for "All Overdose" death rate. These missing values were replaced with zero.

Dataset Link: https://bit.ly/2x7MHbk
Method:

1. Cleaning the Dataset:
Initially, the dataset had 20 columns and 50 rows. Each column represented 2 sets of data for the same year: all overdose death rates and opioid overdose death rates. I loaded the data with 'readr' library and separated the dataset into 2 groups. I used 'tidyr' and 'dplyr' to clean the dataset. Afterwards, I combined all the columns for death rates into 1 single row and joined the subsets to one dataset.

I also looked for another dataset for state abbreviation and combined it to the existing dataset for creating map visualization.

2. The App:
First, I set the layout of the application and made some initial graphs (not Interactive) to show on the app and added them. Afterwards, I made the Interactive graphs, tested them on R and then I added them to the app with the interactive features. After adding all the graphs, I formatted the app to make it more visually appealing, added information page and deployed it. Upon deployment, I saw some minor glitches and made slight changes to the codes to fix it.
