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
                                 tabName = "map", icon = icon("mapdata")),
                        menuItem("Data", 
                                 tabName = "data"),
                        menuItem("Information", 
                                 tabName = "info", icon = icon("info"))
                            ),
                    
                    selectizeInput("selected",
                                   "Select Item to Display", choice1)
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
                     tabItem(tabName = "general", 'Summary of Plots',
                        fluidRow(box(plotOutput('hist1')))),
                     tabItem(tabName = 'Graphs', 'will add info soon'),
                     tabItem(tabName = "map", "Map will be addded"),
                     tabItem(tabName = "data",
                             fluidRow(box(DT::dataTableOutput("Data"),
                                          width = 12))),
                     tabItem(tabName = "info")
                        ),
                 )
    ))














