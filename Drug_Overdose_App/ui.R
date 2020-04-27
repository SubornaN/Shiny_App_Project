library(shinydashboard)

shinyUI(dashboardPage(skin = "purple",
  
############################################ DASHBOARD LAYOUT 
  
                
                dashboardHeader(
                                title = "Opioid Overdose\nDeath Analysis",
                                titleWidth = 300
                                ), 
                    
                dashboardSidebar(
                        sidebarUserPanel("Author: Suborna Nath"),
                    
                        sidebarMenu(
                                menuItem("Overview",
                                         tabName = "intro", icon = icon('book-reader')),
                                
                                menuItem("Interactive Graphs",
                                         tabName = 'Graphs', icon = icon('chart-line')),
                                
                                menuItem("Map Visualization",
                                         tabName = "map", icon = icon("map")),
                                
                                menuItem("Data Table", 
                                         tabName = "data", icon = icon('database')),
                                
                                menuItem("Information", 
                                         tabName = "info", icon = icon("book"))
                                    )
                                ), 
                
############################################### FONT STYLE
                
                dashboardBody(
                         tags$head(
                         tags$style(
                               HTML(
                                '.main-header .logo {
                                font-family: "Georgia", Times, "Century Gothic", serif;
                                font-weight: bold;
                                font-size: 16px;
                                                    }'
                                    )
                                    )
                                  ),
                            
################################################# OVERVIEW
                         
                        tabItems(
                             tabItem(tabName = "intro", h2("Overview of Yearly Overdose Death Rates in USA"),
                                     fluidRow(
        
                                       box(plotlyOutput("Graph1"), width = 12),
                                       box(plotlyOutput("Graph2"), width = 12)
                                     )
                                     ),
                     
########################################## INTERACTIVE GRAPHS
                
                            tabItem(tabName = 'Graphs', 
                                       h2('State Level Comparison of Drug Overdose Death Rates'),
        
                                      fluidRow(box(
                                                  plotlyOutput('iGraph3'), width = 9), 
                                               box(
                                                 h4('Pick a year to see death rates comparison across all states'),
                                                 selectizeInput(inputId = 'Year2',
                                                                 label = 'Select a Year',
                                                                 choices = YearID),
                                                  width = 3)
                                                  ),
                                              
                                    
                                      fluidRow(
                                        box(plotlyOutput('iGraph2'), width = 9), 
                                        
                                        box( h4('These graphs compare
                                                trends between 3 states of your choice 
                                                for "All Overdose" and "Opioid Overdose".
                                                Pick 3 different states from the 3 drop down menus below.'),
                                          selectizeInput(inputId = 'Location1',
                                                         label = 'Select State 1',
                                                         choices = LocationID),
                                          
                                          selectizeInput(inputId = 'Location2',
                                                         label = 'Select State 2',
                                                         choices = LocationID),
                                          
                                          selectizeInput(inputId = 'Location3',
                                                         label = 'Select State 3',
                                                         choices = LocationID), 
                                          width = 3),
                                               ),
                                    
                                    
                                    fluidRow(box(
                                      plotlyOutput('iGraph1'), width = 9),
                                      
                                      box(
                                        h4('Pick a state to see death rates ratio 
                                                       from 2009 - 2018.'),
                                        selectizeInput(inputId = 'Location',
                                                       label = 'Select a State',
                                                       choices = LocationID),
                                        width = 3)
                                    ),
                                                
                                    ),
                
#################################################### MAP 
                     
                     tabItem(
                             tabName = "map", 
                             h2("Heat Map of USA Drug Overdose Death Rate from 2009 - 2018"),
                             

                             fluidRow(
                               box(h4('Pick an year to see trends across USA 
                                       for both "All Overdose" and 
                                       "Opioid Overdose" death rates.'),
                                   selectizeInput(inputId = 'Year1',
                                              label = 'Select an Year',
                                              choices = YearID),
                                   width = 3),
                               infoBoxOutput("maxBox1"),
                               infoBoxOutput("maxBox2"),
 
                               box(plotlyOutput('Map2'), width = 11),
                               box(plotlyOutput('Map1'), width = 11)
                               )
                              ),
                     
############################################### DATA TABLE
                     
                     tabItem(
                             tabName = "data", 
                             h2("Data Set of Overdose Death Rates from 2009 - 2018"),
                             fluidRow(box(DT::dataTableOutput("table"),
                             width = 12))
                             ),

############################################### INFORMATION 

                     tabItem(tabName = "info",
                             h1('About Me'),
                             h3('Author: Suborna Nath'),
                             h3('Email: subornadnath@gmail.com'),
                             h3('Github: https://github.com/SubornaN'),
                             h3('LinkedIn: linkedin.com/in/subornanath/'),
                             
                             h1('About Project'),
                             h3('Dataset: https://bit.ly/2x7MHbk'),
                             h3('Description: The purpose of this web application 
                                is to explore the impact of opioid overdose deaths on total overdose deaths across USA.
                                The data was collected from Kaiser Family Foundation (KFF) website. 
                                It includes data on opioid overdose death rate and total overdose death 
                                rate, per state, by year from 2009 to 2018. The web application includes 
                                4 tabs. The "Overview" tab gives an overview of yearly overdose death 
                                rates in USA. The "Interactive Graphs" tab shows state level analysis for drug 
                                overdose rate and lets users interact with the data. The "Map Visualization" tab
                                shows a heat map of overdose deaths across USA. Lastly, the "Data Table" tab shows
                                the data used to make this visualization web application.'),
                             h3('Disclaimer: For North Dakota, there were 6 missing data points from 2009 to 2013 for
                                "Opioid Overdose" death rate and 1 missing data point for 2011 for 
                                "All Overdose" death rate. These missing values were replaced with zero.')
                             )
                        )
                 )
    ))


