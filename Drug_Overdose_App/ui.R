library(shinydashboard)

shinyUI(dashboardPage(
                skin = "red",
                dashboardHeader(title = "Drug Death Analysis",
                                titleWidth = 230), 
                    
                dashboardSidebar(
                        sidebarUserPanel("Creator: Suborna Nath"),
                    
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
        
                dashboardBody(
                             tags$head(
                             tags$style(HTML('
                              .main-header .logo {
                                font-family: "Georgia", Times, "Century Gothic", serif;
                                font-weight: bold;
                                font-size: 16px;
                              }'
                            ))),
                         
                 tabItems(
                     tabItem(tabName = "intro", h2("Summary of Trends"),
                             fluidRow(

                               box(plotlyOutput("Graph1"), width = 12),
                               box(plotlyOutput("Graph2"), width = 12)
                             )
                             ),
                                
                     tabItem(tabName = 'Graphs', h2('Text'),
                             fluidRow(box(
                                          selectizeInput(inputId = 'Location1',
                                                         label = 'Select a Location',
                                                         choices = locationID),
                                          plotlyOutput('Graph3'),
                                          width = 6
                                          )
                                          )
                                      
                                      ),
                     
                     tabItem(tabName = "map", h2("Heat Map of USA for Drug Overdose"),
                             fluidRow(
                               box(
                                 selectizeInput(inputId = 'Year1',
                                                label = 'Select an Year',
                                                choices = YearID), width = 6,
                                 infoBoxOutput("maxBox1"),
                                 infoBoxOutput("maxBox2")
                               ),
                               
                               box(plotlyOutput('Map1'), width = 10),
                               
                               box(plotlyOutput('Map2'), width = 10)
    
                               )
                              ),
                     
                     tabItem(tabName = "data",
                             fluidRow(box(DT::dataTableOutput("table"),
                                          width = 12))),
                     tabItem(tabName = "info")
                        )
                 )
    ))






