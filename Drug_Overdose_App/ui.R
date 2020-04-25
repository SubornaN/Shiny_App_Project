library(shinydashboard)

shinyUI(dashboardPage(
                skin = "red",
                dashboardHeader(title = "Drug Death Analysis",
                                titleWidth = 230), 
                    
                dashboardSidebar(
                        sidebarUserPanel("Creator: Suborna Nath"),
                    
                        sidebarMenu(
                                menuItem("General",
                                         tabName = "general", icon = icon('general')),
                                menuItem("Interactive Graphs",
                                         tabName = 'Graphs'),
                                menuItem("Map Visualization",
                                         tabName = "map", icon = icon("map")),
                                menuItem("Data Table", 
                                         tabName = "data", icon = icon('database')),
                                menuItem("Information", 
                                         tabName = "info")
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
                     tabItem(tabName = "general", h2("write something"),
                             fluidRow(
                               box(textOutput('Text1'), width = 12),
                               box(plotlyOutput("Line1"), width = 6),
                               box(plotlyOutput("Bar1"), width = 6)
                             )
                             ),
                                
                     tabItem(tabName = 'Graphs', 'will add info soon'),
                     
                     tabItem(tabName = "map", "Map will be addded"),
                     
                     tabItem(tabName = "data",
                             fluidRow(box(DT::dataTableOutput("table"),
                                          width = 12))),
                     tabItem(tabName = "info")
                        )
                 )
    ))






